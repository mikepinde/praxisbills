require "spec_helper"

describe BillItemsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/bill_items" }.should route_to(:controller => "bill_items", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/bill_items/new" }.should route_to(:controller => "bill_items", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/bill_items/1" }.should route_to(:controller => "bill_items", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/bill_items/1/edit" }.should route_to(:controller => "bill_items", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/bill_items" }.should route_to(:controller => "bill_items", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/bill_items/1" }.should route_to(:controller => "bill_items", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/bill_items/1" }.should route_to(:controller => "bill_items", :action => "destroy", :id => "1")
    end

  end
end
