class StartImagesController < InheritedResources::Base
  before_filter :authenticate_superuser!
end
