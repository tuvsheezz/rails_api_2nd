class AddReviewsCountToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :reviews_count, :integer, null: false, default: 0
  end
end
