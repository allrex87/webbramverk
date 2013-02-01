class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|

      t.string "status_name", :limit => 20, :null => false

      t.timestamps
    end
  end
end
