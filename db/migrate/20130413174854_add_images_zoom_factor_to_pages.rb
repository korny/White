class AddImagesZoomFactorToPages < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.integer :images_zoom_factor, default: 300, null: false, after: :text
    end
  end
end
