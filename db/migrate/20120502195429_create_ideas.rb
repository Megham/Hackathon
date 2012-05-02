class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.text :desctiption
      t.string :owner

      t.timestamps
    end
  end
end
