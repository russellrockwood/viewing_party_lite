class RemoveMoviesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :movies, force: :cascade
  end
end
