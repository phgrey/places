require 'spec_helper'

describe "places/edit" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :title => "MyString",
      :lang => "MyString",
      :city_id => 1,
      :contacts => "MyText",
      :content => "MyText"
    ))
  end

  it "renders the edit place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => places_path(@place), :method => "post" do
      assert_select "input#place_title", :name => "place[title]"
      assert_select "input#place_lang", :name => "place[lang]"
      assert_select "input#place_city_id", :name => "place[city_id]"
      assert_select "textarea#place_contacts", :name => "place[contacts]"
      assert_select "textarea#place_content", :name => "place[content]"
    end
  end
end
