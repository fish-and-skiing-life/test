
#coding: utf-8
require 'gmail'
require 'selenium-webdriver'
require 'roo'
require 'net/http'
require 'uri'
require 'json'
require './Constants.rb'
require 'mail'

class Insight_error_checker
    def initialize
        # タイムアウト値を大きくする（デフォルトは60秒。）
        client = Selenium::WebDriver::Remote::Http::Default.new
        client.timeout = 300
        @driver = Selenium::WebDriver.for :chrome, :http_client => client
        #@driver = Selenium::WebDriver.for :chrome
        @mail_ad = "ito.tetsuro.0405@gmail.com"
        @pass ="rose795)bide"
        @admin_mail = "itosouplus@gmail.com"
        @admin_pass = "fn7E0dyuLG:KOS]"
        sign_in()
        
    end

    def sign_in
        @driver.get Constants::Url::SIGN_IN
        @driver.find_element(:id,'agency_email').send_keys @mail_ad
        @driver.find_element(:id, 'agency_password').send_keys @pass
        @driver.find_element(:tag_name,'button').click
    end

    def sign_out
        @driver.find_element(:xpath, Constants::Path::SIGN_OUT).click
    end

    def decision(mode , element_text1,check_text1)
        case mode
        when 0
            return true #経由の場合
        when 1
            if ( element_text1  == check_text1)
                url = now_url
                return true , url
            else
                puts element_text1
                return false
            end
        when 2
            result =  decision(Constants::Mode::DECISION, element_text1,check_text1)
            path =  caputure(caller[0][/`([^']*)'/, 1])
            url = now_url
            return result, path , url
        end
    end

    def caputure(method_name)
        now = Date.today
        day = now.strftime("20%y-%m-%d")
        path = "./Screenshot/"
        path += day
        path += "/"  + method_name
        path += '.png'
        @driver.save_screenshot(path)
        return path
    end

    def now_url
        return  @driver.current_url
    end

    def dash_bord_page(mode)
        @driver.get Constants::Url::DASH_BORD
        check = @driver.find_element(:xpath, Constants::Path::PAGE_HEAD).text
        return decision(mode, check ,'ダッシュボード')
    end

    def compare_page(mode)
        @driver.get Constants::Url::COMPARE
        check = @driver.find_element(:xpath, Constants::Path::PAGE_HEAD).text
        return decision(mode, check,'アカウント比較')
    end

    def hashtag_recomend_page(mode)
        @driver.get Constants::Url::HASHTAG_RECOMEND
        check = @driver.find_element(:xpath, Constants::Path::PAGE_HEAD).text
        return decision(mode, check, 'ハッシュタグリコメンド')
    end
    
    def hashtag_search_page(mode)
        @driver.get Constants::Url::HASHTAG_SEARCH
        check = @driver.find_element(:xpath, Constants::Path::PAGE_HEAD).text
        return decision(mode,check,'ハッシュタグ検索(#instagram)')
    end

    def mypage(mode)
        @driver.get Constants::Url::MYPAGE
        check = @driver.find_element(:xpath, Constants::Path::PAGE_HEAD).text
        return decision(mode, check,'マイページ')
    end

    def more_post_page(mode)
        dash_bord_page(Constants::Mode::COURSE)
        @driver.find_element(:xpath, Constants::Path::MORE_POST_BUTTON).click
        check = @driver.find_element(:xpath, Constants::Path::PAGE_HEAD).text
        decision(mode, check, '投稿一覧')

    end
    def driver_close
        @driver.quit
    end
end

test = Insight_error_checker.new
puts test.more_post_page(1)
test.driver_close
