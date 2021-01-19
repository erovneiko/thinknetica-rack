class TimeFormat

  MAPPING = {
    'year'   => '%Y',
    'month'  => '%m',
    'day'    => '%d',
    'hour'   => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  attr_reader :result_string
  attr_reader :unknown_tokens

  def initialize(format)
    mask = ''
    unknown_tokens = []

    format.split(',').each do |token|
      mask << '-' unless mask.empty?

      if MAPPING.member?(token)
        mask << MAPPING[token]
      else
        unknown_tokens << token
      end
    end

    @result_string = Time.now.strftime(mask) + "\n"
    @unknown_tokens = unknown_tokens.inspect if unknown_tokens.any?
  end

  def success?
    @unknown_tokens.nil?
  end

  def invalid_string
    "Unknown time format #{@unknown_tokens}\n"
  end

end
