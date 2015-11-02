class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :year
    end
  end
end
