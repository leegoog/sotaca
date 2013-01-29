require 'spec_helper'

describe "start_images/edit.html.erb" do
  before(:each) do
    @start_image = assign(:start_image, stub_model(StartImage,
      :link => "MyString",
      :image => "MyString"
    ))
  end

  it "renders the edit start_image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => start_images_path(@start_image), :method => "post" do
      assert_select "input#start_image_link", :name => "start_image[link]"
      assert_select "input#start_image_image", :name => "start_image[image]"
    end
  end
end
