require 'spec_helper'

describe "adresses/show.html.erb" do
  before(:each) do
    @adress = assign(:adress, stub_model(Adress,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Adress1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Adress2/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/County/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Phone1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Phone2/)
  end
end
