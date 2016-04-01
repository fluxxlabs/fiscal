require 'spec_helper'

describe Fiscal do

  it "returns current calendar year start date as fiscal year start, by default" do
    Date.fiscal.year.start.should eql(Date.today.beginning_of_year)
  end

  it "returns current calendar year end date as fiscal end start, by default" do
    Date.fiscal.year.end.should eql(Date.today.end_of_year)
  end

  it "returns '2013-04-01' as fiscal year start date of India for the date '2013-10-10'" do
    Date.fiscal(date: '2013-10-10', mm: 4, dd: 1 ).year.start.should eql('2013-04-01'.to_date)
  end

  it "returns '2013-04-01' as fiscal year start date of India for the date '2014-01-10'" do
    Date.fiscal(date: '2014-01-10', mm: 4, dd: 1 ).year.start.should eql('2013-04-01'.to_date)
  end

  it "returns '2013-04-06' as fiscal year start date of Great Britain for the date '2014-01-10'" do
    Date.fiscal(date: '2014-01-10', mm: 4, dd: 6).year.start.should eql('2013-04-06'.to_date)
  end

  it "returns '2014-10-01' as fiscal quarter start date of US for the date '2014-11-11'" do
    Date.fiscal(date: '2014-11-11', mm: 10, dd: 1).quarter.start.should eql('2014-10-01'.to_date)
  end

  it "returns '2014-10-01' as first fiscal quarter start date of US for the date '2015-08-25'" do
    Date.fiscal(date: '2015-08-25', mm: 10, dd: 1).quarter(1).start.should eql('2014-10-01'.to_date)
  end

  it "returns '2015-06-30' as first fiscal quarter end date of India for the date '2015-08-25'" do
    Date.fiscal(date: '2015-08-25', mm: 4, dd: 1 ).quarter(1).end.should eql('2015-06-30'.to_date)
  end

  it "returns '2015-04-30' as first fiscal month end date of India for the date '2015-08-25'" do
    Date.fiscal(date: '2015-08-25', mm: 4, dd: 1 ).month(1).end.should eql('2015-04-30'.to_date)
  end

  it "returns '2013-05-06' as second fiscal month start date of Great Britain for the date '2014-01-10'" do
    Date.fiscal(date: '2014-01-10', mm: 4, dd: 6).month(2).start.should eql('2013-05-06'.to_date)
  end

  it "returns current calendar year start date as fiscal year start, for today" do
    Date.today.fiscal.year.start.should eql(Date.today.beginning_of_year)
  end

  it "returns the beginning of a quarter for a particular date" do
    Date.fiscal(date: '2014-05-10', mm: 4, dd: 6).quarter.start.should eql('2014-04-06'.to_date)
  end

  it "calculates the previous fiscal quarter" do
    start_date = '2014-05-10'.to_date
    previous_quarter = start_date - 3.month # subtract a quarter
    Date.fiscal(date: previous_quarter, mm: 4, dd: 6).quarter.start.should eql('2014-01-06'.to_date)
  end

  it "calculates the next fiscal quarter" do
    start_date = '2014-05-10'.to_date
    previous_quarter = start_date + 3.month # add a quarter
    Date.fiscal(date: previous_quarter, mm: 4, dd: 6).quarter.start.should eql('2014-07-06'.to_date)
  end

  it "calculates 10th previous fiscal quarter" do
    start_date = '2014-05-10'.to_date
    previous_quarter = start_date - 30.month # subtract 10 quarters
    Date.fiscal(date: previous_quarter, mm: 4, dd: 6).quarter.start.should eql('2011-10-06'.to_date)
  end

  it "calculates the previous fiscal year" do
    start_date = '2014-05-10'.to_date
    previous_quarter = start_date - 1.year # subtract a year
    Date.fiscal(date: previous_quarter, mm: 4, dd: 6).quarter.start.should eql('2013-04-06'.to_date)
  end

  it "calculates the next fiscal year" do
    start_date = '2014-05-10'.to_date
    previous_quarter = start_date + 1.year # add a year
    Date.fiscal(date: previous_quarter, mm: 4, dd: 6).quarter.start.should eql('2015-04-06'.to_date)
  end

  it "calculates 10th previous fiscal year" do
    start_date = '2014-05-10'.to_date
    previous_quarter = start_date - 10.year # subtract 10 years
    Date.fiscal(date: previous_quarter, mm: 4, dd: 6).quarter.start.should eql('2004-04-06'.to_date)
  end

end