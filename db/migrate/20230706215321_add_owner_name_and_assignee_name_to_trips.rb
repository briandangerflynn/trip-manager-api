class AddOwnerNameAndAssigneeNameToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :owner_name, :string
    add_column :trips, :assignee_name, :string
  end
end
