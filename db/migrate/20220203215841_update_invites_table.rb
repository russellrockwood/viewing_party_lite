class UpdateInvitesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :invites, :user_id
    remove_column :invites, :view_party_id
  end
end
