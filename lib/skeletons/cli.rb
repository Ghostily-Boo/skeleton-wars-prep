class CLI

    def initialize
        puts "Brush up on your skeleton knowledge!\nWhich species would you like to learn more about?"
        @@prompt = TTY::Prompt.new
        type = species_get
        puts API.new.image_get(type[0], "skeleton", type[1])
        part = @@prompt.select("A #{type[0]} skeleton is composed of two main parts.\nWhich part would you like to see?", {Appendicular: 1, Axial: 2})
        part == 1 ? appendicular(type[0], type[1]) : axial(type[0], type[1])

    end

    def appendicular(species, group)
        puts "You've reached the #{species} Appendicular Skeleton!"
        API.new.plaintext_get(species, "appendicular+skeleton", group)
    end

    def axial(species)
        puts "You've reached the #{species} Axial Skeleton!"
    end

    def species_get
        choices = {Dog: 1, Horse: 2, Human: 3}
        value = @@prompt.select("Please choose one of the following species:", choices)
        value !=3 ? group = "Animal" : group = ""
        choice = choices.keys[value-1].to_s
        [choice, group]
    end
    
    def part_get(part, list)
        @@prompt.select("These are the components of #{part}.\nWould you like to see more details?", list)
    end

end