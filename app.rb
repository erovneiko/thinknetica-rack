require 'rack'
require './time_format.rb'

class App

  def call(env)
    req = Rack::Request.new(env)

    return response(404) if req.request_method != 'GET' || req.path_info != '/time'

    format = req.params['format']

    return response(400, "Parameter <format> not found\n") if format.nil?

    time_format = TimeFormat.new(format)

    if time_format.success?
      response(200, time_format.result_string)
    else
      response(400, time_format.invalid_string)
    end
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
