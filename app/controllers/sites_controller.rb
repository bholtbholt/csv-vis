class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  def index
    @sites = Site.all
  end

  def upload_csv
    Site.upload_csv(params[:file])
    redirect_to root_path, notice: 'CSV Uploaded'
  end

  def create
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
  end

  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_site
      @site = Site.find(params[:id])
    end

    def site_params
      params.require(:site).permit(:name, keywords_attributes: [:name, :id, :site_id, keyword_entries_attributes: [:date, :google, :google_base_rank, :yahoo, :bing, :global_monthly_searches, :id, :keyword_id]])
    end
end
