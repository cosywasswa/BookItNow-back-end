class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :specialization
      t.text :bio
      t.string :image
      t.decimal :Fee

      t.timestamps
    end
  end
end
