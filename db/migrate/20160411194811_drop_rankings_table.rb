class DropRankingsTable < ActiveRecord::Migration
  def up
    drop_table :rankings
  end
  def up
    create_table :rankings  
  end
end
