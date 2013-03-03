class CreateDailyStatuses < ActiveRecord::Migration
  def change
    create_table :daily_statuses do |t|
      t.integer :project_id, :null => false
      t.text :content
      t.timestamps
    end
  end
end
