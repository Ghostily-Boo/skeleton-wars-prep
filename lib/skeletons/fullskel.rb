class FullSkel

    @@all = []

    def initialize(nest = nil, attributes)
        attributes.each do |key, value|
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.attr_search(species, attribute)
        binding.pry
        all.each do |hash|
            binding.pry
            return hash.values_at(attribute) if hash.species == species
        end
    end

end