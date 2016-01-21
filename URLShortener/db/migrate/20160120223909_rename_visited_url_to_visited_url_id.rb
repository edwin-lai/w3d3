class RenameVisitedUrlToVisitedUrlId < ActiveRecord::Migration
  def change
    change_table :visits do |t|
      t.rename :visited_url, :visited_url_id
    end
  end
end
