class RemoveMovieCastsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :movie_casts
  end
end
