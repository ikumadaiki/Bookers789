class RemoveEvaluationFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :evaluation, :integer
  end
end
