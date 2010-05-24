require File.dirname(__FILE__) + '/../spec_helper'

describe CommentsController do
  before(:each) do
    @my_user = User.make
    @my_user.confirm!
    @my_post = Post.make(:user => @my_user)

  end

  describe "Ajax POST create with valid attributes" do
    before(:each) do
      @valid_attributes = {
        :email  => "test@example.com",
        :author => "author",
        :body   => "body"
      }

    end

    it "should add a new comment" do
      lambda {
        xhr :post, :create, :post_id => @my_post.id, :comment => @valid_attributes
      }.should change(Comment, :count).by(1)
    end
  end

  describe "Ajax POST create with invalid attribute" do
    it "should not add a new comment with missing email" do
      lambda {
        xhr :post, :create, :post_id => @my_post.id,
            :comment => { :email => "", :author => "author", :body => "body" }
      }.should raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not add a new comment with missing author" do
      lambda {
        xhr :post, :create, :post_id => @my_post.id,
            :comment => { :email => "test@abc.com", :author => "", :body => "body" }
      }.should raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not add a new comment with missing body" do
      lambda {
        xhr :post, :create, :post_id => @my_post.id,
            :comment => { :email => "test@abc.com", :author => "author", :body => "" }
      }.should raise_error(ActiveRecord::RecordInvalid)
    end
  end
end

