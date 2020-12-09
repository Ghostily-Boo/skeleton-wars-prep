class FullSkeleton

    @@tracker = {}

    def initialize
        puts "Brush up on your skeleton knowledge!"
        CLI.new
        species
    end
        
    def species
        choices = {Dog: 1, Horse: 2, Human: 3}
        animal = CLI.species_get(choices)
        API.new(animal, "skeleton")
    end
    
end