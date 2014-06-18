class WelcomeController < ApplicationController

  def index

      @site = Site.find(1)
      @latest_news = NewsItem.last
      if @latest_news['body'].length > 200
          @latest_news['body'] = @latest_news['body'].truncate(200)
      end
      require 'json'
      require 'open-uri'
      source = 'http://localhost:8080/?num=1&fields=title,url,body'
      begin
          res = open(source)
          le = JSON.load(res)
          @latest_entry = le[0]
          @latest_entry['body'] = @latest_entry['body'].gsub(/<.*?>/m, ' ')
          if @latest_entry['body'].length > 200
              @latest_entry['body'] = @latest_entry['body'].truncate(200)
          end
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
