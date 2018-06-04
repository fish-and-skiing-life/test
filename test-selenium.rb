require 'selenium-webdriver'
require 'roo'

xlsx = Roo::Excelx.new('./SPRAY for Agencyページ一覧.xlsx')
xlsx.default_sheet = 'Webページ'
driver = Selenium::WebDriver.for :chrome
mail_ad = "tettyann0405@gmail.com"
pass = "arigatou"
sign_in = "http://agency.sp-ray.com/agencies/sign_in"
2.upto(xlsx.last_row) do |row|  
  if xlsx.cell(row, 4) == "Webページ" then
     driver.get sign_in
     driver.find_element(:id, 'agency_email').send_keys mail_ad
     driver.find_element(:id, 'agency_password').send_keys pass
     driver.find_element(:tag_name, "button").click
     url = "http://agency.sp-ray.com/"
     url +=  xlsx.cell(row, 2)    #2列目を1行ずつ取得する
     url = url.sub(/\(.:format\)/ , "")
     driver.get url
     wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
     sleep 2
     driver.find_element(:link_text => 'ログアウト').click
  end
end

driver.quit
