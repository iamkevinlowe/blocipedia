class AddSlugToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :slug, :string, index: true
  end
end
