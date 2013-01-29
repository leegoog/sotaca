require 'spec_helper'

describe "start_images/show.html.erb" do
  before(:each) do
    @start_image = assign(:start_image, stub_model(StartImage,
      :link => "Link",
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Link/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Image/)
  end
end
