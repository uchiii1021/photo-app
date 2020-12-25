class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :category_name
      t.string :category_image

      t.timestamps
    end
  end
end
