class NewsItemsController < ApplicationController
  before_action :set_news_item, only: [:show, :edit, :update, :destroy]

  # GET /news_items
  # GET /news_items.json
  # useless comment
  def index
    @news_items = NewsItem.all.order('created_at DESC')
    @news_items.each do |news_item|
        if news_item['body'].length > 200
            news_item['body'] = news_item['body'].gsub(/<.*?>/m, ' ')
            news_item['body'] = news_item['body'].truncate(200)
        end
    end

  end

  # GET /news_items/1
  # GET /news_items/1.json
  def show
  end

  # GET /news_items/new
  def new
    @news_item = NewsItem.new
  end

  # GET /news_items/1/edit
  def edit
  end

  # POST /news_items
  # POST /news_items.json
  def create
    if signed_in?
    
        @news_item = NewsItem.new(news_item_params)

        respond_to do |format|
          if @news_item.save
            format.html { redirect_to @news_item, notice: 'News item was successfully created.' }
            format.json { render :show, status: :created, location: @news_item }
          else
            format.html { render :new }
            format.json { render json: @news_item.errors, status: :unprocessable_entity }
          end
        end
    else 
        flash[:notice] = 'You are not authorized to do this.'
        respond_to do |format|
            format.html { redirect_to :back }
            format.json { head :no_content }
        end
    end
  end

  # PATCH/PUT /news_items/1
  # PATCH/PUT /news_items/1.json
  def update
    if signed_in?
        respond_to do |format|
          if @news_item.update(news_item_params)
            format.html { redirect_to @news_item, notice: 'News item was successfully updated.' }
            format.json { render :show, status: :ok, location: @news_item }
          else
            format.html { render :edit }
            format.json { render json: @news_item.errors, status: :unprocessable_entity }
          end
        end
    else 
        flash[:notice] = 'You are not authorized to do this.'
        respond_to do |format|
            format.html { redirect_to :back }
            format.json { head :no_content }
        end
    end
  end

  # DELETE /news_items/1
  # DELETE /news_items/1.json
  def destroy
    if signed_in?
        @news_item.destroy
        respond_to do |format|
          format.html { redirect_to news_items_url, notice: 'News item was successfully destroyed.' }
          format.json { head :no_content }
        end
    else 
        flash[:notice] = 'You are not authorized to do this.'
        respond_to do |format|
            format.html { redirect_to :back }
            format.json { head :no_content }
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_item
      @news_item = NewsItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_item_params
      params[:news_item].permit(:body)
    end
end
