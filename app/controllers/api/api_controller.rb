class Api::ApiController < ActionController::API
    include Api::ApiExceptionHandler
    def json_response(object, status = :ok)
        render json: object, status: status
    end
    
end