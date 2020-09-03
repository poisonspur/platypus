class WelcomeController < ApplicationController

  def index

      @site = Site.find(1)
      @latest_news = NewsItem.last
      if @latest_news['body'].length > 200
          @latest_news['body'] = @latest_news['body'].truncate(200)
      end
      remote_ip = request.ip
      require 'json'
      require 'open-uri'
      source = 'http://localhost:8081/feeds?feed_name=PoisonSpurBlog&num=1&fields=title,url,body'
      source2 = 'http://localhost:8081/weather?ip=' + remote_ip
      begin
          res = open(source)
          res2 = open(source2)
          le = JSON.load(res)
          wthr = JSON.load(res2)
          @latest_entry = le[0]
          @latest_entry['body'] = @latest_entry['body'].gsub(/<.*?>/m, ' ')
          if @latest_entry['body'].length > 200
              @latest_entry['body'] = @latest_entry['body'].truncate(200)
          end
          @weather = wthr
          Rails.logger.debug(@latest_entry['body'])
      rescue => exc
          Rails.logger.error("Error getting or parsing feed: " + exc.inspect)
          @latest_entry = Hash.new
          @latest_entry["title"] = "Feed Unavailable" 
          @latest_entry["url"] = ''
          @latest_entry["body"] = ''
      end


  end

end
