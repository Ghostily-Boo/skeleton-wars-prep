class CLI

    def initialize
        @api = API.new
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

    def species_get
        choices = ["Dog", "Horse", "Human"]
        @species = @prompt.select("Which species would you like to see?".light_red.bold, choices)
        @species != "Human" ? @group = "Animal" : @group = ""
        FullSkel.new(species: @species, type: @group)
    end

    def main
        species_get
        @api.image_get(@species, "Skeleton", @group)
        choices = [
            "Appendicular Bones",
            "Axial Bones",
            "Main Menu".light_black
        ]
        number = @api.bone_count(@species, "Skeleton", @group)
        puts "_______________________________________________________".cyan
        puts "\n              #{@species.upcase}                       ".bold
        puts "_______________________________________________________".cyan
        puts "\n"
        puts "A #{@species} skeleton has a total of #{number} bones."
        puts "These bones are separated into TWO main parts.\n"
        part = @prompt.select("What would you like to see?".light_red.bold, choices)

        appendicular(@species, @group) if part == "Appendicular Bones"
        axial(@species, @group) if part == "Axial Bones"
        main if part == "Main Menu"
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


    
    def part_get(part, list)
        @prompt.select("These are the components of #{part}.\nWould you like to see more details?", list)
    end

end