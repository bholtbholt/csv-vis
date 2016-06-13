class KeywordEntriesController < ApplicationController
  before_action :set_keyword_entry, only: [:show, :edit, :update, :destroy]

  # GET /keyword_entries
  # GET /keyword_entries.json
  def index
    @keyword_entries = KeywordEntry.all
  end

  # GET /keyword_entries/1
  # GET /keyword_entries/1.json
  def show
  end

  # GET /keyword_entries/new
  def new
    @keyword_entry = KeywordEntry.new
  end

  # GET /keyword_entries/1/edit
  def edit
  end

  def upload_csv
    KeywordEntry.upload_csv(params[:file])
    redirect_to action: "index", notice: "CSV Uploaded"
  end

  # POST /keyword_entries
  # POST /keyword_entries.json
  def create
    @keyword_entry = KeywordEntry.new(keyword_entry_params)

    respond_to do |format|
      if @keyword_entry.save
        format.html { redirect_to @keyword_entry, notice: 'Keyword entry was successfully created.' }
        format.json { render :show, status: :created, location: @keyword_entry }
      else
        format.html { render :new }
        format.json { render json: @keyword_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keyword_entries/1
  # PATCH/PUT /keyword_entries/1.json
  def update
    respond_to do |format|
      if @keyword_entry.update(keyword_entry_params)
        format.html { redirect_to @keyword_entry, notice: 'Keyword entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword_entry }
      else
        format.html { render :edit }
        format.json { render json: @keyword_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keyword_entries/1
  # DELETE /keyword_entries/1.json
  def destroy
    @keyword_entry.destroy
    respond_to do |format|
      format.html { redirect_to keyword_entries_url, notice: 'Keyword entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword_entry
      @keyword_entry = KeywordEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_entry_params
      params.fetch(:keyword_entry, {})
    end
end
