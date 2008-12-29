describe "Allocine" do
  it "find movie" do
    Allocine.find_movie('Plan 9').should == {"13031"=>"Plan 9", "136668"=>"Plan 9 from Outer Space"}
  end
  
  it "find show" do
    Allocine.find_show('XFiles').should == {"182"=>"X-Files : Aux fronti\303\250res du r\303\251el"}
  end
  
  it "lucky movie" do
    Allocine.lucky_movie('Les pirates de la Silicon Valley').is_a?(AllocineMovie).should == true
  end
  
  it "lucky show" do
    Allocine.lucky_show('Stargate').is_a?(AllocineShow).should == true
  end
end