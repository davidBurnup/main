#encoding: utf-8
module Jbuildable
  extend ActiveSupport::Concern

  included do
    def to_builder(api_mode = true, options = {})

      # raise Rails.application.routes.default_url_options[:host].inspect
      c = ApplicationController.new
      s = c.view_context.render(
        partial: "#{api_mode ? "/api/" : ""}#{self.class.to_s.underscore.pluralize}/#{self.class.to_s.underscore}",
        locals: { self.class.model_name.to_s.underscore.to_sym => self, current_user: User.current },
        formats: [:json],
        handlers: [:jbuilder]
      )

      if options[:hashed]
        s = JSON.parse(s)
      end

      s
    end
  end
end
