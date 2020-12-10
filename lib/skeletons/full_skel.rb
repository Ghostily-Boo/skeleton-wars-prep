class FullSkeleton

    @@tracker = {}
        
    def species
        animal = CLI.species_get(choices)
        API.new(animal, "skeleton")
    end
    
end