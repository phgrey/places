require 'spec_helper'

describe Parse::Mapia do
  it "should find 20 items on a last page" do
    page = Download.last
    tsk = Parse::Mapia.find(page.parsetask_id)
    found = tsk.parse page
    found.size.should eq(20)
  end
end
