class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |link|
      link.string :url, :short_url
      link.integer :click_count, :default => 0

      link.references :user
    end
  end
end
