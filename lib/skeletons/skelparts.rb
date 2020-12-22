class SkelParts
    
    @@all = []

    def initialize(attributes)
        attributes.each do |key, value|
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.add_attr(animal, part, attributes)

    end

    def self.attr_search(species, part, attribute)

    end

end
#.gsub(/\s+/, "_").downcase.to_sym