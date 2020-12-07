class CLI
    SPECIES = ["dog", "human", "horse"]

    def initialize
        puts "Brush up on your skeleton knowledge!/n
            We have information on the following species: dog, horse, human"
        species_get
    end

    def species_get
        puts "Enter species name:"
        species = gets.strip
        #if species.lowercase matches SPECIES, FullSkeleton.new(species)
        #returns species picture, number of bones
        #else puts "Please enter a valid species name:"
        puts "Please enter APPENDICULAR or AXIAL to learn more about those skeletal groups./n
            or COMPARE [Species] to see another species' skeletal image."
    end

end