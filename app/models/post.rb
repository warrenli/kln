class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy

  validates_presence_of :title, :body, :user

  attr_accessible :title, :body, :published_on

  scope :by_user, lambda {|user|  {:conditions => ["user_id = ?" , user.id] } }
  scope :active, where(:deleted => false)

  def destroy
    delete!
  end

  private

  def delete!
    unless self.deleted
      self.deleted = true
      save!
    end
  end
end

