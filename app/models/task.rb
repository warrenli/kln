class Task < ActiveRecord::Base
  attr_accessible :description, :priority, :due_on

  validates_presence_of :description, :priority, :due_on

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

