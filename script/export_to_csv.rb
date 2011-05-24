# -*- encoding : utf-8 -*-
require 'rubygems'
require File.dirname(__FILE__)+'/../config/application'
require File.dirname(__FILE__)+'/../config/environment'

FasterCSV.open("temp.csv", "w") do |csv|
  csv << ["line1row1", "line1row2"]
  csv << ["line2row1", "line2row2"]
  # ...
end

