class CreateRankings < ActiveRecord::Migration
  def up
    create_table :rankings do |t|
      t.string :search_date
      t.string :search_site
      t.string :search_keyword
      t.string :search_market
      t.string :search_location
      t.string :search_device
      t.integer :google
      t.integer :google_base_rank
      t.integer :yahoo
      t.integer :bing
      t.string :google_url
      t.string :yahoo_url
      t.string :bing_url
      t.decimal :advertiser_competition
      t.integer :global_monthly_searches
      t.integer :regional_monthly_searches
      t.decimal :cdc
      t.string :tags

      t.timestamps null: false
    end
  end

  def down
    drop_table :rankings
  end
end
