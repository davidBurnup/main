module Api
  class ApiController < ::ApplicationController

    include ApiConfig

    def main
      render json:  {
        status: :ok
      }
    end
  end
end
