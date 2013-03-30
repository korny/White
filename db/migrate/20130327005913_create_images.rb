class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.string :caption
      
      t.integer :height, :width
      t.belongs_to :gallery, index: true
      
      t.timestamps
    end
  end
end
