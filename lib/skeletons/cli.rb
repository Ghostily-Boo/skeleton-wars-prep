class CLI

    def initialize
        @prompt = TTY::Prompt.new
        puts "\n\n            @@@@@@@@@@@@@@@@@@             "
        puts '          @@@@@@@@@@@@@@@@@@@@@@@           '
        puts '        @@@@@@@@@@@@@@@@@@@@@@@@@@@         '
        puts '       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@        '
        puts '      @@@@@@@@@@@@@@@/      \@@@/   @       '
        puts '     @@@@@@@@@@@@@@@@\      @@  @___@       '
        puts '     @@@@@@@@@@@@@ @@@@@@@@@@  | \@@@@@     '
        puts '     @@@@@@@@@@@@@ @@@@@@@@@\__@_/@@@@@     '
        puts '      @@@@@@@@@@@@@@@/,/,/./\'/_|.\\\'\,\      '
        puts '        @@@@@@@@@@@@@|  | | | | | | | |     '
        puts '                      \_|_|_|_|_|_|_|_|     '
        puts "____________________________________________".cyan
        puts "\n    Brush up on your skeleton knowledge!     ".bold
        puts "____________________________________________".cyan
        puts "\n"
        puts "What if you or your companion skeleton loses"
        puts "a bone?  Would you know where it goes? Learn"
        puts "each bone's appearance  and  location so you"
        puts "can be completely ready!                    "
        puts "____________________________________________\n".cyan
        main
    end

    def main
        choices = {
            "Appendicular Bones": 1,
            "Axial Bones": 2,
            "Full Skeleton Image": 3,
            "Main Menu": 4
        }
        type = species_get
        puts "\nA #{type[0]} skeleton is composed of two main parts."
        part = @prompt.select("\nWhat would you like to see?", choices)

        appendicular(type[0], type[1]) if part == 1
        axial(type[0], type[1]) if part == 2
        puts API.new.image_get(type[0], "skeleton", type[1]) if part == 3
        main if part == 4
    end

    def appendicular(species, group, call = 1)
        choices = {
            "Appendicular Skeleton Image": 1,
            "Forelimb Image": 2,
            "Hindlimb Image": 3,
            "Compair with Another Animal": 4,
            "Main Menu": 5
        } 
        puts "\nYou're in the #{species} Appendicular Skeleton!"
        list = API.new.plaintext_get(species, "appendicular+skeleton", group) if call == 1
        puts "\nA #{species} appendicular skeleton has #{list.length} bones divided into a few subgroups." if call == 1
        
        choice = @prompt.select("\nWhat would you like to see?", choices)
        case choice
        when 1
            puts API.new.image_get(species, "appendicular+skeleton", "Animal")
        when 2
            puts API.new.image_get(species, "forelimb+bones", "Animal")
        when 3
            puts API.new.image_get(species, "hindlimb+bones", "Animal")
        when 4
            (type = species_get) && (puts API.new.image_get(type[0], "appendicular+bones", type[1]))
        when 5
            main
        end
        appendicular(species, group, 2)
    end

    def axial(species, group, call = 1)
        puts "\nYou're in the #{species} Axial Skeleton!"
        list = API.new.plaintext_get(species, "axial+skeleton", group) if call == 1
        puts "\nA #{species} axial skeleton has #{list.length} bones divided into a few subgroups." if call == 1
        choice = @prompt.select("\nWhat would you like to see?", {"Axial Skeleton Image": 1, "Skull Image": 2, "Compare with Another Animal": 3, "Main Menu": 4})
        puts API.new.image_get(species, "axial+skeleton", "Animal") if choice == 1
        puts API.new.image_get(species, "skull", "Animal") if choice == 2
        (type = species_get) && (puts API.new.image_get(type[0], "skull", type[1]))  if choice == 3
        main if choice == 4
        axial(species, group, 2)
    end

    def species_get
        choices = ["Dog", "Horse", "Human"]
        value = @prompt.select("Which species would you like to see?".red.bold.on_light_cyan, choices)
        value !=3 ? group = "Animal" : group = ""
        choice = choices.keys[value-1]
        FullSkel.new(choice, type: group)
        binding.pry
        [choice, group]
    end
    
    def part_get(part, list)
        @prompt.select("These are the components of #{part}.\nWould you like to see more details?", list)
    end

end