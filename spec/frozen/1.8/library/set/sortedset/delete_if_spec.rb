require File.dirname(__FILE__) + '/../../../spec_helper'
require 'set'

describe "SortedSet#delete_if" do
  before(:each) do
    @set = SortedSet["one", "two", "three"]
  end

  ruby_bug "http://redmine.ruby-lang.org/projects/ruby-18/issues/show?id=115", "1.8.7.7" do
    it "yields each Object in self in sorted order" do
      ret = []
      @set.delete_if { |x| ret << x }
      ret.should == ["one", "two", "three"].sort
    end
  end

  it "deletes every element from self for which the passed block returns true" do
    @set.delete_if { |x| x.size == 3 }
    @set.size.should eql(1)

    @set.should_not include("one")
    @set.should_not include("two")
    @set.should include("three")
  end

  it "returns self" do
    @set.delete_if { |x| x }.should equal(@set)
  end

  it "raises a LocalJumpError when not passed a block" do
    lambda { @set.delete_if }.should raise_error(LocalJumpError)
  end
end
