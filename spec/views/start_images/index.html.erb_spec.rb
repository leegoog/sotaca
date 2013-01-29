require 'spec_helper'

describe "start_images/index.html.erb" do
  before(:each) do
    assign(:start_images, [
      stub_model(StartImage,
        :link => "Link",
        :image => "Image"
      ),
      stub_model(StartImage,
        :link => "Link",
        :image => "Image"
      )
    ])
  end

  it "renders a list of start_images" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
