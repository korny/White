class AddUrlTitleToSections < ActiveRecord::Migration
  def change
    for table in [:sections, :pages, :images]
      change_table table do |t|
        t.string :url_title, null: false, after: :title
        t.index  :url_title
      end
    end
  end
end
