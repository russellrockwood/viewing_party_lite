class AddPartyToInvites < ActiveRecord::Migration[5.2]
  def change
    add_reference :invites, :party, foreign_key: true
  end
end
