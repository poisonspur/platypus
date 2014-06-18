class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
  end

  def show_platypus
    @site = Site.find(1)
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    if signed_in?
        @site = Site.new(site_params)

        respond_to do |format|
          if @site.save
            format.html { redirect_to @site, notice: 'Site was successfully created.' }
            format.json { render :show, status: :created, location: @site }
          else
            format.html { render :new }
            format.json { render json: @site.errors, status: :unprocessable_entity }
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

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    if signed_in?
        respond_to do |format|
          if @site.update(site_params)
            format.html { redirect_to @site, notice: 'Site was successfully updated.' }
            format.json { render :show, status: :ok, location: @site }
          else
            format.html { render :edit }
            format.json { render json: @site.errors, status: :unprocessable_entity }
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

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    if signed_in?
        @site.destroy
        respond_to do |format|
          format.html { redirect_to sites_url }
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
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      #params[:site]
      params.require(:site).permit(:base_url, :disp_url, :is_home_ssl, :admin_email, :welcome, :about)
    end
end
