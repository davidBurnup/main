module Api
  class ApiController < ::ApplicationController

    skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
    skip_before_action :unfinalized_callback
    respond_to :json

  end
end
