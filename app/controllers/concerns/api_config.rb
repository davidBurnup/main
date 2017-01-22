module ApiConfig
  extend ActiveSupport::Concern

  included do
    # FIXME : Secure API with doorkeeper !
    # before_action :authorize_user

    skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
    skip_before_action :unfinalized_callback
    respond_to :json
  end

  module ClassMethods
  end
end
