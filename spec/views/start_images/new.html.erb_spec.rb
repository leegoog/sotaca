require 'spec_helper'

describe "start_images/new.html.erb" do
  before(:each) do
    assign(:start_image, stub_model(StartImage,
      :link => "MyString",
      :image => "MyString"
    ).as_new_record)
  end

  it "renders new start_image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => start_images_path, :method => "post" do
      assert_select "input#start_image_link", :name => "start_image[link]"
      assert_select "input#start_image_image", :name => "start_image[image]"
    end
  end
end
