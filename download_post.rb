#!/usr/bin/env ruby
require 'net/http'
require 'json'
require 'uri'
require 'fileutils'
require 'date'

class PostDownloader
  BASE_URL = 'https://hebankowy.pl/api/posts'
  
  def initialize
    @posts_dir = '_posts'
    @images_dir = 'assets/images/posts'
    
    FileUtils.mkdir_p(@posts_dir)
    FileUtils.mkdir_p(@images_dir)
  end
  
  def download_post(slug)
    puts "Downloading post: #{slug}"
    
    # Fetch post data from API
    post_data = fetch_post_data(slug)
    return false unless post_data
    
    # Download images
    download_post_images(post_data)
    
    # Create markdown file
    create_markdown_file(post_data)
    
    puts "✅ Post '#{post_data['title']}' downloaded successfully!"
    true
  rescue => e
    puts "❌ Error downloading post '#{slug}': #{e.message}"
    false
  end
  
  def list_available_posts
    puts "Fetching list of available posts..."
    
    uri = URI("#{BASE_URL}")
    response = Net::HTTP.get_response(uri)
    
    if response.code == '200'
      posts = JSON.parse(response.body)
      puts "\nAvailable posts:"
      posts.each_with_index do |post, index|
        puts "#{index + 1}. #{post['slug']} - #{post['title']}"
      end
      posts
    else
      puts "❌ Failed to fetch posts list"
      []
    end
  rescue => e
    puts "❌ Error fetching posts: #{e.message}"
    []
  end
  
  private
  
  def fetch_post_data(slug)
    uri = URI("#{BASE_URL}/#{slug}")
    response = Net::HTTP.get_response(uri)
    
    if response.code == '200'
      JSON.parse(response.body)
    else
      puts "❌ Failed to fetch post '#{slug}' (HTTP #{response.code})"
      nil
    end
  end
  
  def download_post_images(post_data)
    return unless post_data['photos']
    
    year = Date.parse(post_data['published_at']).year
    year_dir = File.join(@images_dir, year.to_s)
    FileUtils.mkdir_p(year_dir)
    
    post_data['photos'].each do |photo|
      download_image(photo['url'], year_dir, photo['title'] || 'image')
    end
    
    # Download featured image if exists
    if post_data['featured_photo']
      download_image(post_data['featured_photo']['url'], year_dir, 'featured')
    end
  end
  
  def download_image(url, destination_dir, filename_base)
    return unless url
    
    # Convert relative URL to absolute
    image_url = url.start_with?('http') ? url : "https://hebankowy.pl#{url}"
    
    uri = URI(image_url)
    response = Net::HTTP.get_response(uri)
    
    if response.code == '200'
      # Extract file extension from URL
      extension = File.extname(uri.path)
      extension = '.jpg' if extension.empty?
      
      # Clean filename
      clean_filename = filename_base.gsub(/[^a-zA-Z0-9\-_]/, '-').downcase
      filename = "#{clean_filename}#{extension}"
      filepath = File.join(destination_dir, filename)
      
      File.write(filepath, response.body)
      puts "  📷 Downloaded: #{filename}"
      
      # Return relative path for use in markdown
      "/#{filepath}"
    else
      puts "  ❌ Failed to download image: #{url}"
      url # Return original URL as fallback
    end
  rescue => e
    puts "  ❌ Error downloading image #{url}: #{e.message}"
    url # Return original URL as fallback
  end
  
  def create_markdown_file(post_data)
    date = Date.parse(post_data['published_at'])
    slug = post_data['slug']
    filename = "#{date.strftime('%Y-%m-%d')}-#{slug}.md"
    filepath = File.join(@posts_dir, filename)
    
    # Prepare frontmatter
    frontmatter = {
      'layout' => 'post',
      'title' => post_data['title'],
      'date' => date.strftime('%Y-%m-%d'),
      'categories' => post_data['categories']&.map { |c| c['name'] } || [],
      'slug' => slug
    }
    
    # Add optional fields
    frontmatter['featured_image'] = process_image_path(post_data['featured_photo']['url']) if post_data['featured_photo']
    frontmatter['location'] = post_data['location'] if post_data['location']
    frontmatter['distance'] = post_data['distance'] if post_data['distance']
    frontmatter['route'] = post_data['route'] if post_data['route']
    frontmatter['likes'] = post_data['likes'] if post_data['likes'] && post_data['likes'] > 0
    
    # Process comments
    if post_data['comments'] && !post_data['comments'].empty?
      frontmatter['comments'] = post_data['comments'].map do |comment|
        {
          'author' => comment['author_name'],
          'date' => Date.parse(comment['created_at']).strftime('%Y-%m-%d'),
          'content' => comment['content']
        }
      end
    end
    
    # Create markdown content
    content = post_data['content'] || ''
    
    # Process images in content
    content = process_content_images(content, date.year)
    
    # Write file
    File.open(filepath, 'w') do |file|
      file.puts '---'
      frontmatter.each do |key, value|
        if value.is_a?(Array)
          file.puts "#{key}:"
          value.each { |item| file.puts "  - #{item.is_a?(Hash) ? item.to_yaml.lines[1..-1].join : item}" }
        else
          file.puts "#{key}: #{value.is_a?(String) ? "\"#{value.gsub('"', '\"')}\"" : value}"
        end
      end
      file.puts '---'
      file.puts
      file.puts content
    end
    
    puts "  📝 Created: #{filename}"
  end
  
  def process_image_path(url)
    return url unless url
    url.start_with?('http') ? url : url
  end
  
  def process_content_images(content, year)
    # This is a basic implementation - you might need to adjust based on your content format
    content.gsub(/src="([^"]+)"/) do |match|
      url = $1
      if url.start_with?('/uploads/')
        # Convert to Jekyll asset path
        "src=\"/assets/images/posts/#{year}/#{File.basename(url)}\""
      else
        match
      end
    end
  end
end

# Main script
if __FILE__ == $0
  downloader = PostDownloader.new
  
  if ARGV.empty?
    puts "Usage:"
    puts "  ruby download_post.rb <post-slug>     # Download specific post"
    puts "  ruby download_post.rb --list         # List available posts"
    puts
    puts "Example:"
    puts "  ruby download_post.rb hiking-sudety-mountains"
    exit 1
  end
  
  if ARGV[0] == '--list'
    posts = downloader.list_available_posts
    exit 0
  end
  
  slug = ARGV[0]
  success = downloader.download_post(slug)
  exit(success ? 0 : 1)
end