# frozen_string_literal: true
class AddNamePictureToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :picture, :string
  end
end
