class DropPartiesColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :parties, :movie_id
  end
end
