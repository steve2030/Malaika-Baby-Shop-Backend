class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.string :image
      t.string :categories
      t.decimal :price
      t.boolean :in_stock

      t.timestamps
    end
  end
end
