class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_sitewide_vars

  def set_sitewide_vars
      require 'json'
      require 'open-uri'
      source = 'http://localhost:8080/?feed_name=PoisonSpurBlog&num=10&fields=title,url'
      begin
          res = open(source)
          @recent_poisonspur = JSON.load(res)
          @recent_poisonspur.each do |entry|
              entry['title'] = entry['title'].truncate(27)
          end
      rescue => exc
          Rails.logger.error("Error getting or parsing feed: " + exc.inspect)
          @recent_poisonspur = Array.new
          @recent_poisonspur[0] = Hash.new
          @recent_poisonspur[0]["title"] = "Feed Unavailable" 
          @recent_poisonspur[0]["url"] = ''
      end
      @recent_sitenews = NewsItem.order('created_at DESC').all.limit(10)
      @recent_sitenews.each do |item|
          item['body'] = item['body'].truncate(23)
      end
  end

  def current_user
  end

  def login_required
  end

end
