# for now it's just a part of an example ...
require 'spec_helper'

describe NagiosMonitor::ElasticSearch do

	before do
		@es = NagiosMonitor::ElasticSearch.new
	end

	it "should know its elastic search mode" do
		@es.mode.should_not be_nil
	end

	it "should have mode 'none' without elasticsearch detected" do
		@es.mode.should == 'none'
	end

end
