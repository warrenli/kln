class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :email, :author, :body

  validates_presence_of :email, :author, :body
end

