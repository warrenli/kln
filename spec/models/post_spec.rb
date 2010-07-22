require File.dirname(__FILE__) + '/../spec_helper'

describe Post do

  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:body) }
  it { should allow_mass_assignment_of(:published_on) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }

  it { should have_many(:comments) }
  it { should belong_to(:user)}

  describe "being created with valid attributes" do
    before(:each) do
      @user = User.make
      @valid_attributes = {
        :title => "value for title",
        :body  => "value for body",
        :published_on => 5.days.ago
      }
      @post = Post.new(@valid_attributes)
      @post.user = @user
      @post.save!
    end

    it "should have correct association with user" do
      @user.posts.include?(@post).should be_true
      @post.user.should == @user
    end

    it "should have correct by_user scope" do
      result = Post.by_user(@user)
      result[0].should == @post
      result.count.should == 1

      Post.by_user(@user).find(@post.id).should == @post
    end

    it "should be an active post" do
      @post.deleted.should == false
      Post.active.include?(@post).should be_true
    end

    it "should not be physically deleted" do
      lambda { @post.destroy }.should_not change(Post, :count)
    end

    it "should only be marked as deleted" do
      before_count = Post.active.size
      @post.destroy
      after_count = Post.active.size
      (before_count - after_count).should == 1
    end
  end

end

