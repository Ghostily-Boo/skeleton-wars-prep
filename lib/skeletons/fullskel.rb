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
        all.each do |skeleton|
            if skeleton.species == animal
                attributes.each do |key, value|
                    skeleton.class.attr_accessor(key)
                    skeleton.send(("#{key}="), value)
                end
            end
        end
    end

    def self.all
        @@all
    end

    def self.attr_search(species, attribute)
        value = nil
        all.each do |skeleton|
            if skeleton.species == species && skeleton.respond_to?(attribute)
                value = skeleton.method(attribute).call
            end
        end
        value
    end

end