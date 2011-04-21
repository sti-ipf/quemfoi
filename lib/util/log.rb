module Util
  class Log
    def initialize(attributes = {})
      @dt_start = Time.now
      @prefix = attributes[:prefix]
    end

    def log(text)
      puts "#{Time.now.strftime('%Y/%m/%d %H:%M:%S')} - [#{@prefix}] - #{text}"
      text
    end
  end
end

