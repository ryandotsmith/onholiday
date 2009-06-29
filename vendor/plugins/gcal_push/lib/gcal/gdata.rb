module GData
  module Client
    class Base

      def make_request(method, url, body = '')
        headers = self.prepare_headers
        headers['If-Match'] = "*" if method == :put
        headers['If-Match'] = "*" if method == :delete
        request = GData::HTTP::Request.new(url, :headers => headers, 
          :method => method, :body => body)
        
        if @auth_handler and @auth_handler.respond_to?(:sign_request!)
          @auth_handler.sign_request!(request)
        end

        service = http_service.new
        response = service.make_request(request)
        
        case response.status_code  
        when 200, 201, 302
          #Do nothing, it's a success.
        when 401, 403
          raise AuthorizationError, response.body
        when 400
          raise BadRequestError, response.body
        when 409
          raise VersionConflictError, response.body
        when 500
          raise ServerError, response.body
        else
          raise UnknownError, "#{response.status_code} #{response.body}"
        end
        
        return response
      end
      
    end
  end
end