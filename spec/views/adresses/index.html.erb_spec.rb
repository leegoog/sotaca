require 'spec_helper'

describe "adresses/index.html.erb" do
  before(:each) do
    assign(:adresses, [
      stub_model(Adress,
        :title => "Title",
        :name => "Name",
        :country_id => 1,
        :adress1 => "Adress1",
        :adress2 => "Adress2",
        :city => "City",
        :county => "County",
        :zip => 1,
        :phone1 => "Phone1",
        :phone2 => "Phone2"
      ),
      stub_model(Adress,
        :title => "Title",
        :name => "Name",
        :country_id => 1,
        :adress1 => "Adress1",
        :adress2 => "Adress2",
        :city => "City",
        :county => "County",
        :zip => 1,
        :phone1 => "Phone1",
        :phone2 => "Phone2"
      )
    ])
  end

  it "renders a list of adresses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Adress1".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Adress2".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "County".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phone1".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phone2".to_s, :count => 2
  end
end
