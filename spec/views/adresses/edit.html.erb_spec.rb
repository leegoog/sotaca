require 'spec_helper'

describe "adresses/edit.html.erb" do
  before(:each) do
    @adress = assign(:adress, stub_model(Adress,
      :title => "MyString",
      :name => "MyString",
      :country_id => 1,
      :adress1 => "MyString",
      :adress2 => "MyString",
      :city => "MyString",
      :county => "MyString",
      :zip => 1,
      :phone1 => "MyString",
      :phone2 => "MyString"
    ))
  end

  it "renders the edit adress form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => adresses_path(@adress), :method => "post" do
      assert_select "input#adress_title", :name => "adress[title]"
      assert_select "input#adress_name", :name => "adress[name]"
      assert_select "input#adress_country_id", :name => "adress[country_id]"
      assert_select "input#adress_adress1", :name => "adress[adress1]"
      assert_select "input#adress_adress2", :name => "adress[adress2]"
      assert_select "input#adress_city", :name => "adress[city]"
      assert_select "input#adress_county", :name => "adress[county]"
      assert_select "input#adress_zip", :name => "adress[zip]"
      assert_select "input#adress_phone1", :name => "adress[phone1]"
      assert_select "input#adress_phone2", :name => "adress[phone2]"
    end
  end
end
