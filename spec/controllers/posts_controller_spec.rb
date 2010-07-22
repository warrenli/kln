# require 'spec_helper'
# require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.dirname(__FILE__) + '/../spec_helper'

describe PostsController do

  include Devise::TestHelpers

  before(:each) do
    @my_user = User.make
    @my_user.confirm!
    @other_user = User.make
    @other_user.confirm!
    @my_post = Post.make(:user => @my_user)
    @other_post = Post.make(:user => @other_user)
    sign_out(User)
  end

  it "verify setup OK" do
    @my_post.should_not be_nil
    @my_post.user.should == @my_user
    @my_post.user.should_not == @other_user
    Post.all.should_not be_empty
  end

  shared_examples_for "GET index" do
    it "should response with success" do
      response.should be_success
    end

    it "should render template index" do
      response.should render_template("index")
    end

    it "should assigns @posts" do
      assigns(:posts).include?(@my_post).should be_true
      assigns(:posts).include?(@other_post).should be_true
    end
  end

  shared_examples_for "GET show" do
    context "to get an existing post" do
      before(:each) do
        get :show, :id => @my_post.id
      end

      it "should response with success" do
        response.should be_success
      end

      it "should render template show" do
        response.should render_template("show")
      end

      it "should assign local variable for this post" do
        assigns(:post).should eq(@my_post)
      end
    end

    context "to get a non-existing post" do
      before(:each) do
        get :show, :id => 999999999
      end

      it "should be redirected to index page" do
        response.should redirect_to posts_path
      end
    end
  end

  describe "logged out" do
    before(:each) do
      sign_out(User)
    end

    describe "GET index" do
      before(:each) do
        get :index
      end

      it_should_behave_like "GET index"
    end

    describe "GET show" do
      it_should_behave_like "GET show"
    end

    describe "GET new" do
      before(:each) do
        get :new
      end

      it "should be redirected to login" do
        response.should redirect_to new_user_session_path
      end
    end

    describe "POST create" do
      before(:each) do
        post :create, :post => {}
      end

      it "should be redirected to login" do
        response.should redirect_to new_user_session_path
      end
    end

    describe "GET edit" do
      before(:each) do
        get :edit, :id => @my_post.id
      end

      it "should be redirected to login" do
        response.should redirect_to new_user_session_path
      end
    end

    describe "PUT update" do
      before(:each) do
        put :update, :id => @my_post.id, :post => {}
      end

      it "should be redirected to login" do
        response.should redirect_to new_user_session_path
      end
    end

    describe "GET delete" do
      before(:each) do
        get :delete, :id => @my_post.id
      end

      it "should be redirected to login" do
        response.should redirect_to new_user_session_path
      end
    end

    describe "DELETE destroy" do
      before(:each) do
        delete :destroy, :id => @my_post.id
      end

      it "should be redirected to login" do
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "logged in as @my_user" do
    before(:each) do
      sign_in @my_user
    end

    describe "GET index" do
      before(:each) do
        get :index
      end

      it_should_behave_like "GET index"
    end

    describe "GET show" do
      it_should_behave_like "GET show"
    end

    describe "GET new" do
      before(:each) do
        get :new
      end

      it "should response with success" do
        response.should be_success
      end

      it "should render template new" do
        response.should render_template("new")
      end

      it "should assigns a new post variable" do
        incomplete_post = assigns(:post)
        incomplete_post.should_not be_nil
        incomplete_post.title.should be_nil
        incomplete_post.body.should be_empty
      end
    end

    describe "POST create" do
      context "with valid attributes" do
        before(:each) do
          post :create, :post => { :title => "value for title", :body => "value for body" }
          @new_post = assigns(:post)
        end

        it "should belong to the logged in user" do
          @new_post.should be_instance_of(Post)
          @new_post.user.should eq(@my_user)
        end

        it "should be redirected to show the new post" do
          response.should redirect_to @new_post
        end

      end

      context "with invalid attributes" do
        before(:each) do
          post :create, :post => { :title => "", :body => "value for body" }
          @new_post = assigns(:post)
        end

        it "should render template new" do
          response.should render_template("new")
        end
      end
    end

    describe "GET edit" do
      context "to get a post belonging to current user" do
        before(:each) do
          get :edit, :id => @my_post.id
          @old_post = assigns(:post)
        end

        it "should render template edit" do
          response.should render_template("edit")
        end

        it "should have correct owner" do
          @old_post.user.should eq(@my_user)
        end
      end

      context "to get a post belonging to other user" do
        before(:each) do
          get :edit, :id => @other_post.id
          @old_post = assigns(:post)
        end

        it "should redirect to index page" do
          response.should redirect_to posts_path
        end
      end
    end

    describe "PUT update" do
      context "to change a post belonging to current user with valid attributes" do
        before(:each) do
          put :update, :id => @my_post.id, :post => { :title => @my_post.title + "- Changed" }
          @old_post = assigns(:post)
        end

        it "should be redirected to show this post" do
          response.should redirect_to @my_post
        end
      end

      context "to change a post belonging to current user with invalid attributes" do
        before(:each) do
          put :update, :id => @my_post.id, :post => { :title => "" }
          @old_post = assigns(:post)
        end

        it "should render template edit" do
          response.should render_template("edit")
        end
      end

      context "to change a post belonging to other user" do
        before(:each) do
          put :update, :id => @other_post.id, :post => { :title => @my_post.title + "- Changed" }
          @old_post = assigns(:post)
        end

        it "should be redirected to index page" do
          response.should redirect_to posts_path
        end
      end
    end

    describe "GET delete" do
      context "to get a post belonging to current user" do
        before(:each) do
          get :delete, :id => @my_post.id
          @old_post = assigns(:post)
        end

        it "should render template delete" do
          response.should render_template("delete")
        end

        it "should have correct owner" do
          @old_post.user.should eq(@my_user)
        end
      end

      context "to get a post belonging to other user" do
        before(:each) do
          get :edit, :id => @other_post.id
          @old_post = assigns(:post)
        end

        it "should redirect to index page" do
          response.should redirect_to posts_path
        end
      end
    end


    describe "DELETE destroy" do
      context "to delete a post belonging to current user" do
        before(:each) do
          delete :destroy, :id => @my_post.id
        end

        it "should not found the post" do
          lambda { Post.active.find(@my_post.id) }.should raise_error(ActiveRecord::RecordNotFound)
        end

        it "should be redirected to index page" do
          response.should redirect_to posts_path
        end
      end

      context "to delete a post belonging to current user with cancel flag" do
        before(:each) do
          delete :destroy, :id => @my_post.id, :cancel => true
        end

        it "should still find the post" do
          Post.active.find(@my_post.id).should eq(@my_post)
        end

        it "should be redirected to show page" do
          response.should redirect_to post_path(@my_post)
        end
      end

      context "to delete a post belonging to other user" do
        before(:each) do
          delete :destroy, :id => @other_post.id
        end

        it "should still found the post" do
          Post.active.find(@other_post.id).should eq(@other_post)
        end

        it "should be redirected to index page" do
          response.should redirect_to posts_path
        end
      end

    end
  end

end

