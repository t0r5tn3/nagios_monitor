# for now it's just a part of an example ...
require 'nagios_monitor'

describe NagiosMonitor::ElasticSearch do
	it "broccoli is gross" do
		NagiosMonitor::ElasticSearch.portray("Broccoli").should eql("ungenießbar!")
	end

	it "anything else is delicious" do
		NagiosMonitor::ElasticSearch.portray("Not Broccoli").should eql("Delicious!")
	end

	# this will only tell if gem 'tire' ist available or not
	# it will not tell if an index ist actually used
	it "should know if elastic search is used" do
		NagiosMonitor::ElasticSearch.available.should_not be_nil
	end
end