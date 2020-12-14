class CLI

    def initialize
        puts "Brush up on your skeleton knowledge!\nWhich species would you like to learn more about?"
        @@prompt = TTY::Prompt.new
        type = species_get
        part = @@prompt.select("A #{type[0]} skeleton is composed of two main parts.\nWhich part would you like to see?", {"Appendicular Bones": 1, "Axial Bones": 2, "Full Skeleton Image": 3, "Main Menu": 4})
        appendicular(type[0], type[1]) if part == 1
        axial(type[0], type[1]) if part == 2
        puts API.new.image_get(type[0], "skeleton", type[1]) if part == 3
        CLI.new if part == 4
    end

    def appendicular(species, group, call = 1)
        puts "You're in the #{species} Appendicular Skeleton!"
        list = API.new.plaintext_get(species, "appendicular+skeleton", group) if call == 1
        puts "A #{species} appendicular skeleton has #{list.length} bones divided into a few subgroups." if call == 1
        choice = @@prompt.select("What would you like to see?", {"Appendicular Skeleton Image": 1, "Forelimb Image": 2, "Hindlimb Image": 3, "Compare with Another Animal": 4, "Main Menu": 5})
        puts API.new.image_get(species, "appendicular+skeleton", "Animal") if choice == 1
        puts API.new.image_get(species, "forelimb+bones", "Animal") if choice == 2
        puts API.new.image_get(species, "hindlimb+bones", "Animal") if choice == 3
        (type = species_get) && (puts API.new.image_get(type[0], "appendicular+bones", type[1])) if choice == 4
        CLI.new if choice == 5
        appendicular(species, group, 2)
    end

    def axial(species, group, call = 1)
        puts "You're in the #{species} Axial Skeleton!"
        list = API.new.plaintext_get(species, "axial+skeleton", group) if call == 1
        puts "A #{species} axial skeleton has #{list.length} bones divided into a few subgroups." if call == 1
        choice = @@prompt.select("What would you like to see?", {"Axial Skeleton Image": 1, "Skull Image": 2, "Compare with Another Animal": 3, "Main Menu": 4})
        puts API.new.image_get(species, "axial+skeleton", "Animal") if choice == 1
        puts API.new.image_get(species, "skull", "Animal") if choice == 2
        (type = species_get) && (puts API.new.image_get(type[0], "skull", type[1]))  if choice == 3
        CLI.new if choice == 4
        axial(species, group, 2)
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