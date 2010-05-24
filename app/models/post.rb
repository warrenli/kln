class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy

  validates_presence_of :title, :body, :user

  scope :by_user, lambda {|user|  {:conditions => ["user_id = ?" , user.id] } }

  attr_accessible :title, :body, :published_on
end

