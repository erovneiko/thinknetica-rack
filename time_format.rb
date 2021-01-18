class TimeFormat

  MAPPING = {
    'year'   => '%Y',
    'month'  => '%m',
    'day'    => '%d',
    'hour'   => '%H',
    'minute' => '%M',
    'second' => '%S'
  }

  def initialize(format)
    @format = format
  end

  def map
    mask = ''
    unknown_tokens = []

    @format.split(',').each do |token|
      mask << '-' unless mask.empty?
      mask << MAPPING[token]
    rescue TypeError
      unknown_tokens << token
    end

    [Time.now.strftime(mask) + "\n", unknown_tokens]
  end

end
