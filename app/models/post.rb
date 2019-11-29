class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: { text: true }, length: { minimum: 2}, length: {maximum: 100}
end
