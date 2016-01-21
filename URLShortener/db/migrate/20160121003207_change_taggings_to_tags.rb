class ChangeTaggingsToTags < ActiveRecord::Migration
  def change
    rename_table :taggings, :tags
  end


end
