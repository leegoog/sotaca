require 'spec_helper'

require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  before do
    ImageUploader.enable_processing = true
    @uploader = ImageUploader.new(@product, :asset)
    @uploader.store!(File.open("#{RAILS_ROOT}/thea.jpg"))
  end

  after do
    ImageUploader.enable_processing = false
  end

  context 'the thumb version' do
    it "should scale down a landscape image to fit 165 by 165 pixels" do
      @uploader.thumb.should be_no_larger_than(165, 165)
    end
  end

  context 'the small version' do
    it "should scale down a landscape image to fit within 200 by 200 pixels" do
      @uploader.small.should be_no_larger_than(200, 200)
    end
  end

  it "should make the image readable only to the owner and not executable" do
    @uploader.should have_permissions(0600)
  end
end