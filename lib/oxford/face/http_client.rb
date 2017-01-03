require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class HttpClient
  def initialize(api_key)
    uris = URI.parse("https://api.projectoxford.ai")
    @http = Net::HTTP.new(uris.host, uris.port)
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @api_key = api_key
  end

  def get(path, params = {})
    request = Net::HTTP::Get.new("/face/v1.0#{path}")
    request.content_type = "application/json"
    request['Ocp-Apim-Subscription-Key'] = @api_key

    if params.is_a?(Hash)
      request.set_form_data(params)
    else
      request.body = params
    end

    response = @http.request(request)
    response
  end

  def post(path, params = {})
    request = Net::HTTP::Post.new("/face/v1.0#{path}")
    request.content_type = "application/json"
    request['Ocp-Apim-Subscription-Key'] = @api_key

    if params.is_a?(Hash)
      request.body = params.to_json
    else
      request.body = params
    end

    response = @http.request(request)
    response
  end

  def put(path, params = {})
    request = Net::HTTP::Put.new("/face/v1.0#{path}")
    request.content_type = "application/json"
    request['Ocp-Apim-Subscription-Key'] = @api_key

    if params.is_a?(Hash)
      request.body = params.to_json
    else
      request.body = params
    end

    response = @http.request(request)
    response
  end

  def patch(path, params = {})
    request = Net::HTTP::Patch.new("/face/v1.0#{path}")
    request.content_type = "application/json"
    request['Ocp-Apim-Subscription-Key'] = @api_key

    if params.is_a?(Hash)
      request.body = params.to_json
    else
      request.body = params
    end

    response = @http.request(request)
    response
  end

  def delete(path, params = {})
    request = Net::HTTP::Delete.new("/face/v1.0#{path}")
    request.content_type = "application/json"
    request['Ocp-Apim-Subscription-Key'] = @api_key

    if params.is_a?(Hash)
      request.set_form_data(params)
    else
      request.body = params
    end

    response = @http.request(request)
    response
  end
end
