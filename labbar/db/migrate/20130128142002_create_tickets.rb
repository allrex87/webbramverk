class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      
      t.references :user
      t.references :project
      t.references :status
      
      t.string "ticket_name", :limit => 40, :null => false
      t.text "description"

      t.timestamps
    end
  end
end
