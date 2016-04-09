class AddUserRefToCars < ActiveRecord::Migration
  def change
    add_reference :cars, :user, index: true, foreign_key: true
  end
end
