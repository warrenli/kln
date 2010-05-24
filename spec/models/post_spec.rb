require File.dirname(__FILE__) + '/../spec_helper'

describe Post do
  before(:each) do
    @user = User.make
    @valid_attributes = {
      :title => "value for title",
      :body  => "value for body",
      :published_on => 5.days.ago
    }
  end

  describe "being created with valid attributes" do
    before(:each) do
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
  end


end

