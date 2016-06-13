class KeywordCollectionsController < ApplicationController
  before_action :set_keyword_collection, only: [:show, :edit, :update, :destroy]

  def index
    @keyword_collections = KeywordCollection.all
  end

  def show
  end

  def new
    @keyword_collection = KeywordCollection.new
  end

  def edit
  end

  def upload_csv
    KeywordCollection.upload_csv(params[:file])
    redirect_to action: "index", notice: "CSV Uploaded"
  end

  def create
    @keyword_collection = KeywordCollection.new(keyword_collection_params)

    respond_to do |format|
      if @keyword_collection.save
        format.html { redirect_to @keyword_collection, notice: 'Keyword collection was successfully created.' }
        format.json { render :show, status: :created, location: @keyword_collection }
      else
        format.html { render :new }
        format.json { render json: @keyword_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @keyword_collection.update(keyword_collection_params)
        format.html { redirect_to @keyword_collection, notice: 'Keyword collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword_collection }
      else
        format.html { render :edit }
        format.json { render json: @keyword_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @keyword_collection.destroy
    respond_to do |format|
      format.html { redirect_to keyword_collections_url, notice: 'Keyword collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_keyword_collection
      @keyword_collection = KeywordCollection.find(params[:id])
    end

    def keyword_collection_params
      params.require(:keyword_collection).permit(:site_id, :keywords, :date, :google, :google_base_rank, :yahoo, :bing, :global_monthly_searches)
    end
end
