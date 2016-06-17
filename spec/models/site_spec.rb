require 'rails_helper'

describe Site do
  describe "#upload_csv" do
    context "with site data" do
      it "creates sites" do
        csv_data = CSV.generate do |csv|
          csv << ["Date", "Site"]
          csv << ["2016-02-01", "First Site"]
          csv << ["2016-02-02", "Second Site"]
        end

        csv_file = Tempfile.new('new_csv.csv')
        csv_file.write(csv_data)
        csv_file.rewind

        Site.upload_csv(csv_file)
        expect(Site.count).to eq 2
      end

      it "doesn't duplicate sites" do
        csv_data = CSV.generate do |csv|
          csv << ["Date", "Site"]
          csv << ["2016-02-01", "First Site"]
          csv << ["2016-02-01", "Second Site"]
          csv << ["2016-02-02", "Second Site"]
        end

        csv_file = Tempfile.new('new_csv.csv')
        csv_file.write(csv_data)
        csv_file.rewind

        Site.upload_csv(csv_file)
        expect(Site.count).to eq 2
      end
    end

    context "with keyword data" do
      it "creates keywords" do
        csv_data = CSV.generate do |csv|
          csv << ["Date", "Site", "Keyword"]
          csv << ["2016-02-01", "First Site", "First Keyword"]
          csv << ["2016-02-01", "Second Site", "Second Keyword"]
        end

        csv_file = Tempfile.new('new_csv.csv')
        csv_file.write(csv_data)
        csv_file.rewind

        Site.upload_csv(csv_file)
        expect(Keyword.count).to eq 2
      end

      it "doesn't duplicate keywords" do
        csv_data = CSV.generate do |csv|
          csv << ["Date", "Site", "Keyword"]
          csv << ["2016-02-01", "First Site", "First Keyword"]
          csv << ["2016-02-01", "First Site", "Second Keyword"]
          csv << ["2016-02-02", "First Site", "Second Keyword"]
        end

        csv_file = Tempfile.new('new_csv.csv')
        csv_file.write(csv_data)
        csv_file.rewind

        Site.upload_csv(csv_file)
        expect(Keyword.count).to eq 2
      end
    end

    context "with keyword entry data" do
      it "creates keyword entries" do
        csv_data = CSV.generate do |csv|
          csv << ["Date", "Site", "Keyword", "Google", "Google Base Rank", "Yahoo", "Bing", "Global Monthly Searches"]
          csv << ["2016-02-01", "First Site", "First Keyword", "10", "20", "30", "40", "100"]
          csv << ["2016-02-02", "First Site", "First Keyword", "10", "20", "30", "40", "100"]
          csv << ["2016-02-03", "First Site", "First Keyword", "10", "20", "30", "40", "100"]
        end

        csv_file = Tempfile.new('new_csv.csv')
        csv_file.write(csv_data)
        csv_file.rewind

        Site.upload_csv(csv_file)
        expect(KeywordEntry.count).to eq 3
      end

      it "updates keyword entries rather than duplicating them" do
        csv_data = CSV.generate do |csv|
          csv << ["Date", "Site", "Keyword", "Google", "Google Base Rank", "Yahoo", "Bing", "Global Monthly Searches"]
          csv << ["2016-02-01", "First Site", "First Keyword", "10", "20", "30", "40", "100"]
          csv << ["2016-02-01", "First Site", "First Keyword", "50", "20", "30", "40", "100"]
        end

        csv_file = Tempfile.new('new_csv.csv')
        csv_file.write(csv_data)
        csv_file.rewind

        Site.upload_csv(csv_file)
        expect(KeywordEntry.count).to eq 1
        expect(KeywordEntry.first.google).to eq 50
      end
    end
  end
end

# Additional Tests to be added
#########################
# converts to lowercase
# converts to snake_case
# understands col separation
# finds a date
# updates/adds to entry/keyword/site if already exists
# discards extra data
