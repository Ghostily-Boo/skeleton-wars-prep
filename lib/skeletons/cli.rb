class CLI
    SPECIES = ["dog", "human", "horse"]

    def initialize
        puts "Brush up on your skeleton knowledge!"
        puts "We have information on the following species: dog, horse, human"
        species_get
    end

    def species_get
        puts "Enter species name:"
        species = gets.strip
        #if species.lowercase matches SPECIES, FullSkeleton.new(species)
    end

end