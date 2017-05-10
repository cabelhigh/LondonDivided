class AddOutstandingPayoutToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :outstanding_payout, :integer, array: true, default: []
  end
end
