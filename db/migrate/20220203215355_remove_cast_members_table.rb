class RemoveCastMembersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :cast_members, force: :cascade
  end
end
