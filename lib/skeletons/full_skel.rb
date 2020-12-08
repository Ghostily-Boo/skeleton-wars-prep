class FullSkeleton

    @@tracker = {}

    def initialize
        puts "Brush up on your skeleton knowledge!"
        CLI.new
        species
    end
        
    def species
        choices = {Dog: 1, Horse: 2, Human: 3}
        CLI.species_get(choices)

        # if tracker includes species
        #     give back something from hash
        # else
        #     Api.new(species, part)
        # end
    end
    
end