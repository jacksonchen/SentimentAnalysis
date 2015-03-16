class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.string :word
      t.float :value
      t.timestamps null: false
    end
  end
end
