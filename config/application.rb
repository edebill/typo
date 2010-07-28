require File.expand_path('../boot', __FILE__)

require 'rails/all'
Bundler.require :default, Rails.env

module Typo
  class Application < Rails::Application
    # Skip frameworks you're not going to use
    #config.frameworks -= [ :active_resource ]
  
    # Setup the cache path
    config.action_controller.page_cache_directory = "#{Rails.root}/public/cache/"
    config.cache_store=:file_store, "#{Rails.root}/public/cache/"
  
  
    # I need the localization plugin to load first
    # Otherwise, I can't localize plugins <= localization
    # Forcing manually the load of the textfilters plugins fixes the bugs with apache in production.
    config.plugins = [ :localization, :all ]
    
    config.autoload_paths += %W(
      vendor/rubypants
      vendor/akismet
      vendor/flickr
      vendor/uuidtools/lib
      vendor/rails/railties
      vendor/rails/railties/lib
      vendor/rails/actionpack/lib
      vendor/rails/activesupport/lib
      vendor/rails/activerecord/lib
      vendor/rails/actionmailer/lib
      app/apis
    ).map {|dir| "#{Rails.root}/#{dir}"}.select { |dir| File.directory?(dir) }
    
    # Use the filesystem for sessions instead of the database
    config.action_controller.session = { :key => "_typo_session", :secret => "8d7879bd56b9470b659cdcae88792622" }
    
    # Disable use of the Accept header, since it causes bad results with our
    # static caching (e.g., caching an atom feed as index.html).
    config.action_controller.use_accept_header = false
  
    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector
    config.active_record.observers = :email_notifier, :web_notifier
  end
  
  # Load included libraries.
  require 'rubypants'
  require 'uuidtools'
  
  require 'migrator'
  require 'rails_patch/active_record'
  require 'rails_patch/active_support'
  require 'login_system'
  require 'typo_version'
  $KCODE = 'u'
  require 'jcode'
  require 'transforms'
  
  $FM_OVERWRITE = true
  require 'filemanager'
  
  ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
    :long_weekday => '%a %B %e, %Y %H:%M'
  )
  
  ActionMailer::Base.default_charset = 'utf-8'
  
  # Work around interpolation deprecation problem: %d is replaced by
  # {{count}}, even when we don't want them to.
  # FIXME: We should probably fully convert to standard Rails I18n.
  require 'i18n_interpolation_deprecation'
  class I18n::Backend::Simple
    def interpolate(locale, string, values = {})
      interpolate_without_deprecated_syntax(locale, string, values)
    end
  end
  
  if Rails.env != 'test'
    begin
      mail_settings = YAML.load(File.read("#{Rails.root}/config/mail.yml"))
  
      ActionMailer::Base.delivery_method = mail_settings['method']
      ActionMailer::Base.server_settings = mail_settings['settings']
    rescue
      # Fall back to using sendmail by default
      ActionMailer::Base.delivery_method = :sendmail
    end
  end
end
