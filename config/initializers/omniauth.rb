require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '505160336252698', '697d038ec7dad0a0238ddd8d7ea8e38c'
end