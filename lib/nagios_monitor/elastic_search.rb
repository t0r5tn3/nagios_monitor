# watch out !

module NagiosMonitor
  class ElasticSearch
    def self.portray(food)
      if food.downcase == "broccoli"
        "ungenießbar!"
      else
        "Delicious!"
      end
    end

    def self.available
    	if Gem::Specification::find_all_by_name('tire').any?
    		puts Tire::Configuration.url()
    		true
    	else
    		false
		end
    end
  end
end
