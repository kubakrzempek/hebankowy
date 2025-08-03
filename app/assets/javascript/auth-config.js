var config = {
  baseUrl: '/',
  // Logins happen at the POST /sessions/ endpoint
  loginUrl: '/api/sessions',
  // The API serves its tokens with a key of id_token which differs from
  // aurelia-auth's standard
  tokenName: 'id_token',
  // Once logged in, we want to redirect the user to the welcome view
  loginRedirect: '/admin',
  logoutRedirect: '/',
}

export default config;
