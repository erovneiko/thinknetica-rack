require 'rack'
require './time_format.rb'

class App

  def call(env)
    req = Rack::Request.new(env)

    return response(404) if req.request_method != 'GET' || req.path_info != '/time'

    format = req.params['format']

    return response(400, "Parameter <format> not found\n") if format.nil?

    result_string, unknown_tokens = TimeFormat.new(format).map

    return response(400, "Unknown time format #{unknown_tokens.inspect}\n") if unknown_tokens.any?

    response(200, result_string)
  end

  def response(status, message = nil)
    res = Rack::Response.new

    if message
      res['Content-Type'] = 'text/plain'
      res.write message
    end

    res.status = status
    res.finish
  end

end
