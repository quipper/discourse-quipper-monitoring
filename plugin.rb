# frozen_string_literal: true

# name: quipper-monitoring
# about: Enable site monitoring for sentry and newrelic
# version: 0.0.1
# authors: Discourse
# required_version: 3.0

# once newrelic config and gem installed it's ready to monitor

ENV['NRCONFIG'] ||= File.expand_path('../newrelic.yml', __FILE__)
gem 'newrelic_rpm', '9.0.0'

gem 'sentry-ruby', '5.8.0'
gem 'sentry-rails', '5.8.0'

enabled_site_setting :quipper_monitoring

after_initialize do
  if SiteSetting.quipper_monitoring

    if SiteSetting.quipper_sentry && SiteSetting.quipper_sentry_dsn.present?
      Sentry.init do |config|
        config.dsn = SiteSetting.quipper_sentry_dsn
        config.breadcrumbs_logger = [:active_support_logger, :http_logger]
        
        # ignore ApplicationController::RenderEmpty
        # ApplicationController::RenderEmpty happened 
        # when some controller that extends ApplicationController not call `render`
        # config.before_send = lambda do |event, hint|
        #   message = event.dig(:logentry, :formatted)
        #   return nil if message.include?('ApplicationController::RenderEmpty')
        #   event
        # end
      end

      class ::ApplicationController
        def rescue_with_handler(exception)
          handle_exception(exception)
          super
        end
    
        private
    
        def handle_exception(exception)
          fingerprint = [
            exception.class.name,
            exception.message,
          ]

          Sentry.set_tags(context: "#{controller_path.gsub('/', '_').camelize.capitalize}Controller##{params[:action]}")
          Sentry.capture_exception(exception, fingerprint: fingerprint)
        end
      end
    end
  end
  # Code which should run after Rails has finished booting
end
