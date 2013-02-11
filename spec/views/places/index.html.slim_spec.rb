require 'spec_helper'

describe "places/index" do
  before(:each) do
    assign(:places, [
      stub_model(Place,
        :title => "Title",
        :lang => "Lang",
        :city_id => 1,
        :contacts => "MyText",
        :content => "MyText"
      ),
      stub_model(Place,
        :title => "Title",
        :lang => "Lang",
        :city_id => 1,
        :contacts => "MyText",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of places" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Lang".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
