require File.dirname(__FILE__) + '/../spec_helper'

describe User do

  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:time_zone) }
  it { should allow_mass_assignment_of(:roles) }

  it { should have_many(:posts) }

  describe "being created with valid email & password" do
    before(:each) do
      @user = User.make
      @user.confirm!
    end

    it "should have confirmation_token be nil" do
      @user.confirmation_token.should be_nil
    end

    it "should have confirmed_at token not be nil" do
      @user.confirmed_at.should_not be_nil
    end

    it "should have confirmation_sent_at not be nil" do
      @user.confirmation_sent_at.should_not be_nil
    end

    it "should have no role" do
      @user.roles.should be_empty
    end
  end

  describe "- roles -" do
    before(:each) do
      @user = User.make
    end

    it "should accept multiple roles" do
      valid_roles = User::ROLES
      @user.roles = valid_roles
      @user.roles.should_not be_empty
      @user.roles.should == valid_roles
      @user.roles.count.should == valid_roles.count
      @user.is?(:banned).should be_true
      @user.is?(:admin).should be_true
      @user.is?(:guest).should be_true
    end

    it "should ignore invalid role" do
      @user.roles = %w[ unknown ]
      @user.roles.should be_empty
      @user.is?(:unknown).should be_false
    end

    it "empty role is not the same as banned" do
      @user.roles.should be_empty
      @user.is?(:banned).should_not be_true

      @user.roles = %w[ banned ]
      @user.roles.should_not be_empty
    end

  end

  describe "mass assignment" do
    before(:each) do
      @valid_roles = User::ROLES
      @valid_attributes = {
        :email     => "test@example.com",
        :password  => "password",
        :password_confirmation => "password",
        :time_zone => "Hong Kong",
        :roles => @valid_roles
      }
    end

    it "should accept roles" do
      user = User.new(@valid_attributes)
      user.save.should be_true
      user.roles.should == @valid_roles
    end
  end

end

