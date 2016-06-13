class KeywordCollectionsController < ApplicationController
  before_action :set_keyword_collection, only: [:show, :edit, :update, :destroy]

  # GET /keyword_collections
  # GET /keyword_collections.json
  def index
    @keyword_collections = KeywordCollection.all
  end

  # GET /keyword_collections/1
  # GET /keyword_collections/1.json
  def show
  end

  # GET /keyword_collections/new
  def new
    @keyword_collection = KeywordCollection.new
  end

  # GET /keyword_collections/1/edit
  def edit
  end

  # POST /keyword_collections
  # POST /keyword_collections.json
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

  # PATCH/PUT /keyword_collections/1
  # PATCH/PUT /keyword_collections/1.json
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

  # DELETE /keyword_collections/1
  # DELETE /keyword_collections/1.json
  def destroy
    @keyword_collection.destroy
    respond_to do |format|
      format.html { redirect_to keyword_collections_url, notice: 'Keyword collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword_collection
      @keyword_collection = KeywordCollection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_collection_params
      params.require(:keyword_collection).permit(:site_id, :keywords, :date, :google, :google_base_rank, :yahoo, :bing, :global_monthly_searches)
    end
end
