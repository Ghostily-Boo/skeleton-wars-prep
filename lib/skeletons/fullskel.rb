class FullSkel

    @@all = []

    def initialize(attributes)
        attributes.each do |key, value| 
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
        self.class.all << self
        binding.pry
    end

    def self.all
        @@all
    end

end