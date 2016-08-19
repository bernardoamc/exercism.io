class CreateTeamMembershipRequestsTable < ActiveRecord::Migration
  def change
    create_table :team_membership_requests do |t|
      t.integer :team_id, null: false
      t.integer :user_id, null: false
      t.boolean :denied, null: false, default: false
      t.timestamps null: false
    end

    add_index :team_membership_requests, [:team_id, :user_id]
  end
end
