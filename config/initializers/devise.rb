Devise.setup do |config|
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"
  require "devise/orm/active_record"
  config.secret_key = ENV["SECRET_KEY"]
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.scoped_views = true
  config.omniauth :facebook, ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_APP_SECRET"], { scope: "email" }
  config.omniauth :google_oauth2, ENV["GOOGLE_OAUTH2_APP_ID"], ENV["GOOGLE_OAUTH2_APP_SECRET"], { scope: "email" }
  config.omniauth_path_prefix = '/users/auth'
end
