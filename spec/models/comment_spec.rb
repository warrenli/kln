require File.dirname(__FILE__) + '/../spec_helper'

describe Comment do

  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:author) }
  it { should allow_mass_assignment_of(:body) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:body) }

  it { should belong_to(:post) }

  describe "being created with valid attributes" do
    before(:each) do
      @user = User.make
      @post = Post.make(:user => @user)
      @valid_attributes = {
        :email  => "test@example.com",
        :author => "value for author",
        :body   => "value for body"
      }
      @comment = Comment.new(@valid_attributes)
      @comment.post = @post
      @comment.save!
    end

    it "should have correct association with post" do
      @post.comments.include?(@comment).should be_true
      @comment.post.should == @post
    end
  end
end

