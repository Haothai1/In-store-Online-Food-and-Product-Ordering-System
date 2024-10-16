class AddStatusToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :status, :string, default: 'open'
  end
end
