module Constants
    module Url
        SIGN_IN = 'https://insight.sp-ray.com/agencies/sign_in'
        DASH_BORD = 'https://insight.sp-ray.com/home/dashboard'
        COMPARE ='https://insight.sp-ray.com/compare/index'
        HASHTAG_RECOMEND = 'https://insight.sp-ray.com/home/hashtags'
        HASHTAG_SEARCH = 'https://insight.sp-ray.com/home/hashtag/instagram'
        MYPAGE = 'https://insight.sp-ray.com/agencies/edit'
    end

    module Path
        SIGN_OUT ='//*[@id="page-wrapper"]/div[1]/nav/ul/li/a'
        PAGE_HEAD ='//*[@id="page-wrapper"]/div[2]/div[1]/div[1]/h2'
        MORE_POST_BUTTON ='//*[@id="page-wrapper"]/div[2]/div[2]/div/div/div[3]/div[2]/div[1]/div/div[2]/div/div[2]/a' 
    end

    module Mode
        COURSE = 0
        DECISION =1
        CAPUTURE =2
    end
end

