class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.belongs_to :section, null: false, index: true
      
      t.string  :title
      t.text    :text
      t.integer :position
      
      t.timestamps
    end
  end
end
