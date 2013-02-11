require 'spec_helper'

describe "places/new" do
  before(:each) do
    assign(:place, stub_model(Place,
      :title => "MyString",
      :lang => "MyString",
      :city_id => 1,
      :contacts => "MyText",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => places_path, :method => "post" do
      assert_select "input#place_title", :name => "place[title]"
      assert_select "input#place_lang", :name => "place[lang]"
      assert_select "input#place_city_id", :name => "place[city_id]"
      assert_select "textarea#place_contacts", :name => "place[contacts]"
      assert_select "textarea#place_content", :name => "place[content]"
    end
  end
end
