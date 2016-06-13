class KeywordEntriesController < ApplicationController
  before_action :set_keyword_entry, only: [:show, :edit, :update, :destroy]

  def index
    @keyword_entries = KeywordEntry.all
  end

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

  def destroy
    @keyword_entry.destroy
    respond_to do |format|
      format.html { redirect_to keyword_entries_url, notice: 'Keyword entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_keyword_entry
      @keyword_entry = KeywordEntry.find(params[:id])
    end

    def keyword_entry_params
      params.require(:site).permit(:date, :google, :google_base_rank, :yahoo, :bing, :global_monthly_searches)
    end
end
