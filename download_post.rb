#!/usr/bin/env ruby
require 'net/http'
require 'json'
require 'uri'
require 'fileutils'
require 'date'
require 'set'
require 'cgi'
require 'addressable/uri'

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

    # Download all images (including new image fields)
    download_all_post_images(post_data)

    # Create markdown file with enhanced frontmatter
    create_enhanced_markdown_file(post_data)

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
      data = JSON.parse(response.body)
      puts "📊 Post data fetched: #{data.keys.join(', ')}"
      data
    else
      puts "❌ Failed to fetch post '#{slug}' (HTTP #{response.code})"
      nil
    end
  end

  def download_all_post_images(post_data)
    year = Date.parse(post_data['published_at']).year
    year_dir = File.join(@images_dir, year.to_s)
    FileUtils.mkdir_p(year_dir)

    puts "📁 Created directory: #{year_dir}"

    # Download main post images with proper naming (banner, cover, etc.)
    image_fields = [
      ['featured_photo_url', '_featured'],
      ['banner_photo_url', '_banner'],
      ['cover_photo_url', '_cover'],
      ['mobile_cover_photo_url', '_mobile_cover'],
      ['mobile_featured_photo_url', '_mobile_featured']
    ]

    image_fields.each do |field, suffix|
      if post_data[field]
        puts "🖼️  Downloading #{field}: #{post_data[field]}"
        download_image_with_suffix(post_data[field], year_dir, suffix)
      end
    end

    # Download featured_photo object if exists
    if post_data['featured_photo'] && post_data['featured_photo']['url']
      puts "🖼️  Downloading featured_photo.url: #{post_data['featured_photo']['url']}"
      download_image_with_suffix(post_data['featured_photo']['url'], year_dir, '_featured')
    end

    # Download cover object if exists
    if post_data['cover'] && post_data['cover']['url']
      puts "🖼️  Downloading cover.url: #{post_data['cover']['url']}"
      download_image_with_suffix(post_data['cover']['url'], year_dir, '_cover')
    end

    # Download SEO image if exists
    if post_data['seo'] && post_data['seo']['image']
      puts "🖼️  Downloading seo.image: #{post_data['seo']['image']}"
      download_image_with_suffix(post_data['seo']['image'], year_dir, '_seo')
    end

    # Download content images (from photos array or embedded in content)
    if post_data['photos']
      post_data['photos'].each_with_index do |photo, index|
        puts "🖼️  Downloading photo #{index + 1}: #{photo['url']}"
        download_image_with_suffix(photo['url'], year_dir, "")
      end
    end

    # Process and download content images from HTML
    if post_data['content']
      download_content_images(post_data['content'], year_dir)
    end
  end

  def download_image_with_suffix(url, destination_dir, suffix)
    return unless url

    # Convert relative URL to absolute HTTPS
    image_url = url.start_with?('http') ? url.gsub('http://', 'https://') : "https://hebankowy.pl#{url}"

    # Handle non-ASCII characters in the URL
    begin
      uri = URI(image_url)
    rescue URI::InvalidURIError
      # Use addressable gem to handle non-ASCII characters properly
      addressable_uri = Addressable::URI.parse(image_url)
      uri = URI(addressable_uri.normalize.to_s)
    end

    begin
      response = Net::HTTP.get_response(uri)

      if response.code == '200'
        # Extract original filename and add suffix
        original_filename = File.basename(uri.path.split('?').first) # Remove query params like ?sha=
        # URL decode the filename to handle Polish characters properly
        original_filename = CGI.unescape(original_filename)
        name_part = File.basename(original_filename, '.*')
        extension = File.extname(original_filename)

        final_filename = "#{name_part}#{suffix}#{extension}"
        filepath = File.join(destination_dir, final_filename)

        File.open(filepath, 'wb') do |file|
          file.write(response.body)
        end

        puts "  ✅ Downloaded: #{final_filename}"
        return final_filename
      else
        puts "  ❌ Failed to download #{url} (HTTP #{response.code})"
      end
    rescue => e
      puts "  ❌ Error downloading #{url}: #{e.message}"
    end

    nil
  end

  def download_content_images(content, year_dir)
    puts "🖼️  Processing content images..."

    # Find all picture elements and process them
    picture_blocks = content.scan(/<picture>(.*?)<\/picture>/m)

    picture_blocks.each do |picture_content|
      picture_html = picture_content[0]

      # Extract source tag (desktop version) - handle both attribute orders
      source_match = picture_html.match(/<source[^>]*media="\(min-width:\s*(\d+)px\)"[^>]*(?:srcset|src)="([^"]+)"/i) ||
                     picture_html.match(/<source[^>]*(?:srcset|src)="([^"]+)"[^>]*media="\(min-width:\s*(\d+)px\)"/i)

      if source_match
        if source_match[1] && source_match[2]
          # First pattern: media first, then srcset
          width = source_match[1]
          desktop_url = source_match[2]
        else
          # Second pattern: srcset first, then media
          desktop_url = source_match[1]
          width = source_match[2]
        end

        puts "🖼️  Downloading content image (desktop #{width}px): #{desktop_url}"
        # Download the desktop version without any suffix for Jekyll templates
        download_image_with_suffix(desktop_url, year_dir, "")
      end

      # Extract img tag (mobile/cropped version)
      img_match = picture_html.match(/<img[^>]*(?:src|srcset)="([^"]+)"/i)
      if img_match
        mobile_url = img_match[1]

        puts "🖼️  Downloading content image (cropped): #{mobile_url}"
        download_image_with_suffix(mobile_url, year_dir, "_cropped")
      end
    end

    # Also handle standalone img tags (not inside picture elements)
    standalone_imgs = content.scan(/<img[^>]*(?:src|srcset)="([^"]+)"[^>]*>/i)

    standalone_imgs.each do |match|
      url = match[0]
      next unless url.include?('/uploads/') # Process only uploaded images

      # Check if this img is truly standalone (not inside a picture tag)
      # Look for a complete picture block that contains this URL
      is_inside_picture = false
      picture_blocks = content.scan(/<picture>(.*?)<\/picture>/m)
      picture_blocks.each do |picture_content|
        if picture_content[0].include?(url)
          is_inside_picture = true
          break
        end
      end

      next if is_inside_picture

      puts "🖼️  Downloading standalone content image: #{url}"
      # For standalone images, download without suffix (they're usually full-size)
      download_image_with_suffix(url, year_dir, "")
    end
  end

  def download_image(url, destination_dir, filename_base)
    return unless url

    # Convert relative URL to absolute
    image_url = url.start_with?('http') ? url : "https://hebankowy.pl#{url}"

    # Properly encode the URL to handle non-ASCII characters
    begin
      uri = URI(image_url)
    rescue URI::InvalidURIError
      # Use addressable gem to handle non-ASCII characters properly
      addressable_uri = Addressable::URI.parse(image_url)
      uri = URI(addressable_uri.normalize.to_s)
    end

    begin
      response = Net::HTTP.get_response(uri)

      if response.code == '200'
        # Preserve original file extension and case
        original_filename = File.basename(uri.path)
        extension = File.extname(original_filename)

        # Use original filename if available, otherwise use provided base
        final_filename = original_filename.empty? ? "#{filename_base}#{extension}" : original_filename
        filepath = File.join(destination_dir, final_filename)

        File.open(filepath, 'wb') do |file|
          file.write(response.body)
        end

        puts "  ✅ Downloaded: #{final_filename}"
        return final_filename
      else
        puts "  ❌ Failed to download #{url} (HTTP #{response.code})"
      end
    rescue => e
      puts "  ❌ Error downloading #{url}: #{e.message}"
    end

    nil
  end

  def create_enhanced_markdown_file(post_data)
    date = Date.parse(post_data['published_at'])
    slug = post_data['slug']
    filename = "#{date.strftime('%Y-%m-%d')}-#{slug}.md"
    filepath = File.join(@posts_dir, filename)

    # Prepare enhanced frontmatter with all schema fields
    frontmatter = {
      'layout' => 'post',
      'title' => post_data['title'],
      'date' => date.strftime('%Y-%m-%d'),
      'categories' => post_data['categories']&.map { |c| c['name'] } || [],
      'slug' => slug
    }

    # Add all image fields from schema with proper naming
    year = date.year
    image_fields = {
      'featured_photo_url' => post_data['featured_photo_url'],
      'banner_photo_url' => post_data['banner_photo_url'],
      'cover_photo_url' => post_data['cover_photo_url'],
      'mobile_cover_photo_url' => post_data['mobile_cover_photo_url'],
      'mobile_featured_photo_url' => post_data['mobile_featured_photo_url']
    }

    image_fields.each do |field, url|
      if url
        # Convert to local Jekyll path with proper suffix
        suffix_map = {
          'featured_photo_url' => '_featured',
          'banner_photo_url' => '_banner',
          'cover_photo_url' => '_cover',
          'mobile_cover_photo_url' => '_mobile_cover',
          'mobile_featured_photo_url' => '_mobile_featured'
        }

        original_filename = File.basename(url.split('?').first)
        # URL decode the filename to handle Polish characters properly
        original_filename = CGI.unescape(original_filename)
        name_part = File.basename(original_filename, '.*')
        extension = File.extname(original_filename)
        suffix = suffix_map[field] || ''

        final_filename = "#{name_part}#{suffix}#{extension}"
        frontmatter[field] = "/assets/images/posts/#{year}/#{final_filename}"
      end
    end

    # Handle featured_photo object
    if post_data['featured_photo'] && post_data['featured_photo']['url']
      url = post_data['featured_photo']['url']
      original_filename = File.basename(url.split('?').first)
      # URL decode the filename to handle Polish characters properly
      original_filename = CGI.unescape(original_filename)
      name_part = File.basename(original_filename, '.*')
      extension = File.extname(original_filename)
      final_filename = "#{name_part}_featured#{extension}"
      frontmatter['featured_photo_url'] = "/assets/images/posts/#{year}/#{final_filename}"
    end

    # Handle cover object
    if post_data['cover'] && post_data['cover']['url']
      url = post_data['cover']['url']
      original_filename = File.basename(url.split('?').first)
      # URL decode the filename to handle Polish characters properly
      original_filename = CGI.unescape(original_filename)
      name_part = File.basename(original_filename, '.*')
      extension = File.extname(original_filename)
      final_filename = "#{name_part}_cover#{extension}"
      frontmatter['cover_photo_url'] = "/assets/images/posts/#{year}/#{final_filename}"
      frontmatter['cover_alt'] = post_data['cover']['title'] if post_data['cover']['title']
    end

    frontmatter['distance'] = post_data['distance'] if post_data['distance']
    frontmatter['likes'] = post_data['likes'] if post_data['likes'] && post_data['likes'] > 0
    frontmatter['teaser'] = post_data['teaser'] if post_data['teaser']

    # Add HTML content fields (will be rendered as raw HTML in Jekyll)
    # Note: These could be moved to template-level API calls in the future
    frontmatter['hints'] = post_data['hints'] if post_data['hints']
    frontmatter['route'] = post_data['route'] if post_data['route']
    frontmatter['location'] = post_data['location'] if post_data['location']

    # Add SEO fields
    if post_data['seo']
      frontmatter['seo_title'] = post_data['seo']['title'] if post_data['seo']['title']
      frontmatter['seo_description'] = post_data['seo']['description'] if post_data['seo']['description']
      if post_data['seo']['image']
        url = post_data['seo']['image']
        original_filename = File.basename(url.split('?').first)
        # URL decode the filename to handle Polish characters properly
        original_filename = CGI.unescape(original_filename)
        name_part = File.basename(original_filename, '.*')
        extension = File.extname(original_filename)
        final_filename = "#{name_part}_seo#{extension}"
        frontmatter['seo_image'] = "/assets/images/posts/#{year}/#{final_filename}"
      end
    end

    # Add date fields
    frontmatter['created_at'] = post_data['created_at'] if post_data['created_at']
    frontmatter['updated_at'] = post_data['updated_at'] if post_data['updated_at']
    frontmatter['published_at'] = post_data['published_at'] if post_data['published_at']

    # Process comments (excluding them as per schema notes)
    # Comments are marked as DISREGARD in the schema, so skip them

    # Create markdown content
    content = post_data['content'] || ''

    # Process images in content to use local paths
    content = process_content_images(content, year)

    # Write file with proper YAML formatting
    File.open(filepath, 'w') do |file|
      file.puts '---'
      frontmatter.each do |key, value|
        case value
        when Array
          file.puts "#{key}:"
          value.each { |item| file.puts "  - #{format_yaml_value(item)}" }
        when Hash
          file.puts "#{key}:"
          value.each { |k, v| file.puts "  #{k}: #{format_yaml_value(v)}" }
        else
          file.puts "#{key}: #{format_yaml_value(value)}"
        end
      end
      file.puts '---'
      file.puts
      file.puts content
    end

    puts "  📝 Created: #{filename}"
    puts "  📊 Frontmatter fields: #{frontmatter.keys.join(', ')}"
  end

  def format_yaml_value(value)
    case value
    when String
      if value.include?('"') || value.include?("'") || value.include?("\n") || value.include?(':')
        # Use literal block scalar for complex strings
        "|\n    #{value.gsub("\n", "\n    ")}"
      else
        "\"#{value.gsub('"', '\"')}\""
      end
    when Numeric, TrueClass, FalseClass, NilClass
      value.to_s
    else
      "\"#{value}\""
    end
  end

  def process_content_images(content, year)
    # Process images in content to use local Jekyll paths with proper naming
    processed_content = content.dup

    # Process source tags with media queries (both srcset and src)
    processed_content.gsub!(/<source([^>]*)(?:srcset|src)="([^"]+)"([^>]*)>/i) do |match|
      attributes_before = $1
      url = $2
      attributes_after = $3

      if url.include?('/uploads/')
        # For desktop source tags, use base filename (no suffix)
        original_filename = File.basename(url.split('?').first)
        # URL decode the filename to handle Polish characters properly
        original_filename = CGI.unescape(original_filename)
        name_part = File.basename(original_filename, '.*')
        extension = File.extname(original_filename)
        local_filename = "#{name_part}#{extension}"

        local_url = "{{ '/assets/images/posts/#{year}/#{local_filename}' | relative_url }}"
        # Preserve the original attribute name (srcset or src)
        attr_name = match.match(/(srcset|src)=/i)[1]
        "<source#{attributes_before}#{attr_name}=\"#{local_url}\"#{attributes_after}>"
      else
        match
      end
    end

    # Process img tags
    processed_content.gsub!(/<img([^>]*)src="([^"]+)"([^>]*)>/i) do |match|
      attributes_before = $1
      url = $2
      attributes_after = $3

      if url.include?('/uploads/')
        # For img tags, extract potential srcset media info from nearby source tag
        original_filename = File.basename(url.split('?').first)
        # URL decode the filename to handle Polish characters properly
        original_filename = CGI.unescape(original_filename)
        name_part = File.basename(original_filename, '.*')
        extension = File.extname(original_filename)

        # Check if this is a cropped version by looking for crop parameters
        suffix = url.include?('crop') ? '_cropped' : ''

        local_filename = "#{name_part}#{suffix}#{extension}"
        local_url = "{{ '/assets/images/posts/#{year}/#{local_filename}' | relative_url }}"
        "<img#{attributes_before}src=\"#{local_url}\"#{attributes_after}>"
      else
        match
      end
    end

    # Process srcset attributes on img tags
    processed_content.gsub!(/<img([^>]*)srcset="([^"]+)"([^>]*)>/i) do |match|
      attributes_before = $1
      url = $2
      attributes_after = $3

      if url.include?('/uploads/')
        original_filename = File.basename(url.split('?').first)
        # URL decode the filename to handle Polish characters properly
        original_filename = CGI.unescape(original_filename)
        name_part = File.basename(original_filename, '.*')
        extension = File.extname(original_filename)

        # Assume this is a cropped version if srcset is used
        suffix = '_cropped'

        local_filename = "#{name_part}#{suffix}#{extension}"
        local_url = "{{ '/assets/images/posts/#{year}/#{local_filename}' | relative_url }}"
        "<img#{attributes_before}srcset=\"#{local_url}\"#{attributes_after}>"
      else
        match
      end
    end

    processed_content
  end
end

# CLI Usage
if __FILE__ == $0
  downloader = PostDownloader.new

  if ARGV.empty?
    puts "Usage: ruby download_post.rb <post-slug>"
    puts "   or: ruby download_post.rb --list"
    exit 1
  end

  if ARGV[0] == '--list'
    downloader.list_available_posts
  else
    slug = ARGV[0]
    success = downloader.download_post(slug)
    exit(success ? 0 : 1)
  end
end
