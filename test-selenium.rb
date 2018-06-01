require 'selenium-webdriver'
require 'roo'

xlsx = Roo::Excelx.new('./SPRAY for Agencyページ一覧.xlsx')
xlsx.default_sheet = 'Webページ'

2.upto(xlsx.last_row) do |row|  
  url =  xlsx.cell(row, 2)    #2列目を1行ずつ取得する
  url = url.sub(/\(.:format\)/ , "")
  break
end 
url = "http://agency.sp-ray.com/"
url += xlsx.cell(15,2) 
url = url.sub(/\(.:format\)/ , "")
p url

driver = Selenium::WebDriver.for :chrome
driver.get url

wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
sleep 10
driver.quit
