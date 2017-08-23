Rails.application.config.assets.precompile += %w( application-print.css )

# Includes helpers in assets generators (used for Angular templates Generation)
# Rails.application.assets.context_class.class_eval do
#   include ApplicationHelper
#   include ActionView::Helpers
#   include Rails.application.routes.url_helpers
#   include FontAwesome::Rails::IconHelper
# end
Rails.configuration.assets.precompile += %w[serviceworker.js manifest.json]
