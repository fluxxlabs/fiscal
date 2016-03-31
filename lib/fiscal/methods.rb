module Fiscal

  class Fiscal
    def initialize(options = {})
      @date    = options[:date]
      @mm = options[:mm]
      @dd = options[:dd]
    end

    def year(index = nil)
      FiscalPeriod.new(date: @date, mm: @mm, dd: @dd, type: :year, index: index)
    end

    def half_year(index = nil)
      FiscalPeriod.new(date: @date, mm: @mm, dd: @dd, type: :half_year, index: index)
    end

    def quarter(index = nil)
      FiscalPeriod.new(date: @date, mm: @mm, dd: @dd, type: :quarter, index: index)
    end

    def month(index = nil)
      FiscalPeriod.new(date: @date, mm: @mm, dd: @dd, type: :month, index: index)
    end
  end

end
