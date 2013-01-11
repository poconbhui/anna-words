class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :english
      t.string :translation
      t.boolean :remembered
      t.integer :remembercount

      t.timestamps
    end
  end
end
