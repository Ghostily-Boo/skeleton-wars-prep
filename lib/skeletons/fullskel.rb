class FullSkel

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
        subpart = nil
        if part != "Skeleton"
            subpart = part.gsub(/\W\w*/, "").downcase
        end
        all.each do |skeleton|
            if skeleton.species == animal
                attributes.each do |key, value|
                    key = (subpart + "_" + key.to_s).to_sym if subpart
                    skeleton.class.attr_accessor(key)
                    skeleton.send(("#{key}="), value)
                end
            end
        end
    end

    def self.attr_search(species, part, attribute)
        subpart = nil
        if part != "Skeleton"
            subpart = part.gsub(/\W\w*/, "").downcase
            attribute = (subpart + "_" + attribute.to_s).to_sym if subpart
        end
        value = nil
        all.each do |skeleton|
            if skeleton.species == species && skeleton.respond_to?(attribute)
                value = skeleton.method(attribute).call
            end
        end
        value
    end
end