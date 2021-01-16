require 'rack'

class App

  def call(env)
    req = Rack::Request.new(env)

    return response 404 if req.request_method != 'GET' || req.path_info != '/time'

    format = req.params['format']

    return response 400, "Parameter <format> not found\n" if format.nil?

    result_string, unknown_tokens = mapping(format)

    return response 400, "Unknown time format #{unknown_tokens.inspect}\n" if unknown_tokens.any?

    response 200, result_string
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

  def mapping(format)
    unknown_tokens = []
    result_string = ''

    format.split(',').each do |token|
      result_string << '-' unless result_string.empty?
      result_string << case token
                       when 'year';   Time.now.year.to_s
                       when 'month';  Time.now.month.to_s
                       when 'day';    Time.now.day.to_s
                       when 'hour';   Time.now.hour.to_s
                       when 'minute'; Time.now.min.to_s
                       when 'second'; Time.now.sec.to_s
                       else; unknown_tokens << token; ''
                       end
    end

    [result_string << "\n", unknown_tokens]
  end

end
