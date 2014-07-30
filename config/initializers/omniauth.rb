Rails.application.config.action_dispatch.cookies_serializer = :marshal

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '505160336252698', '697d038ec7dad0a0238ddd8d7ea8e38c'
  provider :google_oauth2, {client_id: '484509374252-sp6ohvjmpvjtgojvvm573gt4bemdl6mu.apps.googleusercontent.com',
   				client_secret: 'MHuaErDJ9ImnKoHJtbnG3Tr2'}
  provider :open_id, name: 'nus_openID', identifier: "https://openid.nus.edu.sg"
end