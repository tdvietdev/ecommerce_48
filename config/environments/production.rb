Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.active_storage.service = :local
  config.log_level = :debug
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  host = "shrouded-stream-40111.herokuapp.com"
  config.action_mailer.default_url_options = { host: host }
  ActionMailer::Base.smtp_settings = {
      address: ConfigMail.address.empty? ? "smtp.sendgrid.net" : ConfigMail.address,
      port: ConfigMail.port.empty? ? "587" : ConfigMail.port,
      authentication: :plain,
      user_name: ConfigMail.user_name.empty? ? ENV["SENDGRID_USERNAME"] : ConfigMail.user_name,
      password: ConfigMail.password.empty? ? ENV["SENDGRID_PASSWORD"] : ConfigMail.password,
      domain: ConfigMail.domain.empty? ? "heroku.com" : ConfigMail.domain,
      enable_starttls_auto: true
  }
end
