class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.references :user
      
      t.string "project_name", :limit => 40, :null => false
      t.text "description"
      t.date "start_date", :null => false
      t.date "end_date", :null => false

      t.timestamps
    end
  end
end
