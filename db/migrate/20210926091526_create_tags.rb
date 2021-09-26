class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name, limit: 50
      t.timestamps
    end
  end
end
