OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1800363220201792', '411eb4ddd2bc1ddb0803ba225a35dcdc'
end
