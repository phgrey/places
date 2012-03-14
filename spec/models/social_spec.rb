require "spec_helper"



module RSpec::Rails
  describe Social do

    h = Hashie::Mash.new({:extra => {:raw_info => {
        :id => 112233221,
        :name => 'Tester',
        :email => 'Tratata@mail.test',
        :login => 'terester',
    }}})

    describe '.extract_data_from_raw' do
      it "should return given data" do
        d = Social.extract_data_from_raw('twitter', h)
        d[:id].should eq(112233221)
        d[:name].should eq('Tester')
        d[:email].should be_nil
      end
    end

    describe '.find_for' do

      it "should create a new user when no existing found" do
        t = Time.now
        u = Social.find_for('twitter', h)
        u.should_not be_nil
        u.persisted?.should be_true
        User.last.should eq(u)
      end





      it "should add auth to an existing user" do



      end

    end
  end
end
