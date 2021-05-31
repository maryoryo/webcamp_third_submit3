class RemoveNaFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :na, :string
  end
end
