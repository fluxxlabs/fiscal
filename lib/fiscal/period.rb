module Fiscal

  class FiscalPeriod

    class FiscalError < StandardError; end

    def initialize(options = {})

      @type    = (options[:type])
      @date    = (options[:date] || Date.today).to_date
      @mm = options[:mm] || 1
      @dd = options[:dd] || 1

      if options[:index]
        # user input
        @index = options[:index].to_i
      elsif @type == :year
        # only 1 year in a fiscal year
        @index = 1
      else
        # if the user does not enter, compute the index
        @index = number
      end

      validate
    end

    def validate
      # date validation is handled by active support
      # index
      valid_indexes = (1..(12 / months_in(type)))
      raise(FiscalError, "`#{@index}` is not a valid index for `#{@type}`") unless valid_indexes.include?(@index)
    end

    def type
      # return type, in case user decides to pass around the return object
      @type
    end

    def start
      # start date
      start_date
    end

    def end
      # find start date for next year, and minus one
      start_date(next: true) - 1
    end

    def number
      if @type == :year
        # if year, return the year number
        self.end.year
      elsif @index
        # if user input index, return it and save some computation
        @index
      else
        # find the number of intervals from start of the year
        start = start_date(type: :year)
        ((months_between(start, @date).to_f) / months_in(@type)).ceil
      end
    end

    def next
      if @index == (12 / months_in(@type))
        date  = @date.change(year: @date.year + 1)
        index = 1
      else
        date  = @date
        index = @index + 1
      end
      self.class.new(date: date, mm: @mm,  dd: @dd, type: @type, index: index)
    end

    def prev
      if @index == 1
        date  = @date.change(year: @date.year - 1)
        index = (12 / months_in(@type))
      else
        date  = @date
        index = @index - 1
      end
      self.class.new(date: date, mm: @mm,  dd: @dd, type: @type, index: index)
    end

    def to_i
      number
    end

    def to_s
      number.to_s
    end

  private
    def start_month
      @mm
    end

    def start_day
      @dd
    end

    def months_between(from, to)
      (to.month - from.month) + 12 * (to.year - from.year) + 1
    end

    def months_in(type)
      {year: 12, half_year: 6, quarter: 3, month: 1}[type]
    end

    def start_date(options = {})
      # get type from options, or default to instance variable
      type = options[:type] || @type

      # override index, especially if ye
      index = (type == :year ? 1 : @index)

      # modifier, 0 for current, 1 for next
      i = options[:next] ? 0 : 1

      # find the start year, if the fiscal year spans across multiple years
      year = (@date.to_date - (start_month - 1).months).year

      # months to offset, for half-year, quarter and month
      add = (index - i) * (months_in(type))

      # construct the start date
      Date.new(year, start_month, start_day) + add.months
    end

  end

end
