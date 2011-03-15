


class Sotaca
   def awesome?
     true
   end
   
   def sweet?
     true
   end  
end   

class BigCartel
end 
  

describe Sotaca do
  
  before(:each) do
    @sotaca = Sotaca.new
  end
  
  it "should be awesome" do
     @sotaca.should be_awesome
  end                   
  
  it do
     @sotaca.should be_sweet
  end                       
  
  it do
    @sotaca.should_not be_an_instance_of(BigCartel)
  end
  
end    

