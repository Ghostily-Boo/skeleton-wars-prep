class FullSkel

    @@all = []

    def initialize(nest = nil, attributes)
        attributes.each do |key, value|
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
        if nest
            all.each do |skeleton|
                if skeleton.species == nest
                    
        self.class.all << self
    end

    def self.add_attr(animal, attributes)
        binding.pry
        all.each {|skeleton| skeleton << attributes if skeleton.species == animal}
        binding.pry
    end

    def self.all
        @@all
    end

    def self.attr_search(species, attribute)
        value = nil
        all.each do |skeleton|
            binding.pry
            if skeleton.species == species && skeleton.respond_to?(attribute)
                value = skeleton.attribute
            end
        end
        binding.pry
        value
    end

end