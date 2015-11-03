class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.references :project, index: true, foreign_key: { name: 'fk_projects_on_project_id' }
      t.string :year
    end
  end
end
