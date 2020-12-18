class FullSkel

    @@all = []

    def initialize(nest = nil, attributes)
        attributes.each do |key, value|
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
        nest ? nest << self : self.class.all << self
        binding.pry
    end

    def self.all
        @@all
    end

end