class Ranking < ActiveRecord::Base
  require 'roo'

  COLUMNS_TO_STRING = ["search_date", "search_site", "search_keyword", "search_market", "search_location",  "search_device", "google", "google_base_rank", "yahoo", "bing", "google_url", "yahoo_url", "bing_url", "advertiser_competition", "global_monthly_searches", "regional_monthly_searches", "cdc", "tags"]

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << COLUMNS_TO_STRING
      all.each do |ranking|
        csv << ranking.attributes.values_at(*COLUMNS_TO_STRING)
      end
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row = clean_for row, COLUMNS_TO_STRING
      ranking = Ranking.find_by(:search_date => row["search_date"], :search_site => row["search_site"], :search_keyword => row["search_keyword"], :search_market => row["search_market"], :search_device => row["search_device"]) || new
      ranking.attributes = row.to_hash.slice(*row.to_hash.keys)
      ranking.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, csv_options: {col_sep: "\t"})
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.clean_for row_as_hash, string_columns_array
    row_as_hash.each do |key, value|
      if string_columns_array.include?key
        #row_as_hash[key] = value.to_i.to_s
        row_as_hash[key] = value.to_s
      end
    end
  end
end
