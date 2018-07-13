class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    # add_column :DB명, :컬럼명, :타입
    add_column :users, :provider,       :string
    add_column :users, :name,           :string
    add_column :users, :uid,            :string
  end
end
