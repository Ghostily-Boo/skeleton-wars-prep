class FullSkel

    @@all = []

    def initialize(attributes)
        attributes.each do |key, value|
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
        self.class.all << self
    end

    def self.add_attr(animal, attributes)
        binding.pry
        all.each do |skeleton|
            if skeleton.species == animal
                self.class.attr_accessor(attributes.keys[0])
                self.send(("#{attributes.key[0]}="), attributes.values[0])
            end
        end
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