class FullSkel

    @@all = []

    def initialize(species, attributes)
        attributes.each do |key, value|
            binding.pry 
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
        binding.pry
        self.class.all << self
    end

    def self.all
        @@all
    end

end