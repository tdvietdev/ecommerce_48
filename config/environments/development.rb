Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end
  config.active_storage.service = :local


  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true

  config.assets.debug = true

  config.assets.quiet = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = {host: "localhost", port: 3000}
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
