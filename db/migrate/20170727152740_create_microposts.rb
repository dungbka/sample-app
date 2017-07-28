class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |table|
      table.text :content
      table.references :user, foreign_key: true

      table.timestamps
    end
  end
end
