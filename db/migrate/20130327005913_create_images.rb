class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :page, null: false, index: true
      
      t.string  :title
      t.string  :caption
      t.integer :height
      t.integer :width
      t.integer :position
      
      t.timestamps
    end
  end
end
