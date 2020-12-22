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

    def species_get(compare = false)
        choices = ["Dog", "Horse", "Human"]
        species = @prompt.select("\nWhich species would you like to see?".light_red.bold, choices)
        species != "Human" ? group = "Animal" : group = ""
        compare ? (@species_second = species) && (@group_second = group) : (@species = species) && (@group = group)
        FullSkel.new(species: species, type: group) unless FullSkel.all.any? {|skeleton| skeleton.species == species}
    end

    def main
        species_get
        puts "\n___________________________________________________".cyan
        puts "\n                       #{@species.upcase}                       ".bold
        puts "___________________________________________________".cyan
        puts "\n"
        @api.image_get(@species, "Skeleton", @group)
        number = @api.bone_count(@species, "Skeleton", @group)
        puts "\n___________________________________________________".cyan
        puts "\nA #{@species} skeleton has a total of #{number} bones." if @species != "Horse"
        puts "\nThese bones are separated into two main parts:"
        puts "Appendicular and Axial."
        puts "\nYou can choose to explore these parts, compare"
        puts "with another animal's image, or pick a new animal."
        puts "___________________________________________________\n".cyan
        main_choices
    end

    def main_choices
        choices = [
            "Appendicular Bones",
            "Axial Bones",
            "Compare",
            "New Species".light_black
        ]
        choice = "Compare"
        until choice != "Compare" do
            choice = @prompt.select("What would you like to see?".light_red.bold, choices)
            if choice == "Appendicular Bones"
                appendicular
            elsif choice == "Axial Bones"
                axial
            elsif choice == "New Species".light_black
                main
            else
                species_get(true)
                @api.image_get(@species_second, "Skeleton", @group_second)
                puts "\nYou're still in the #{@species} Skeleton.".light_red.bold
            end
        end
    end

    def appendicular
        puts "\n___________________________________________________".cyan
        puts "\n            #{@species.upcase} APPENDICULAR SKELETON            ".bold
        puts "___________________________________________________".cyan
        puts "\n"
        @api.image_get(@species, "Appendicular+Skeleton", @group)
        number = @api.bone_count(@species, "Appendicular+Skeleton", @group)
        puts "\n___________________________________________________".cyan
        puts "You're in the #{@species} Appendicular Skeleton!"
        puts "\nA #{@species} Appendicular Skeleton has a total of" if @species != "Horse"
        puts "#{number} bones." if @species != "Horse"
        if @species == "Human"
            parts = ["Upperlimb Bones", "Lowerlimb Bones"]
        else
            parts = ["Forelimbs Bones", "Hindlimbs Bones"]
        end
        puts "\nThese bones are separated into two main parts:"
        puts "#{parts[0]} and #{parts[1]}."
        puts "\nYou can choose to look at subpart images, compare"
        puts "with another animal's image, or pick a new animal."
        puts "___________________________________________________\n".cyan
        choices = [
            parts[0],
            parts[1],
            "Compare",
            "Main Species Select".light_black
        ]
        sub_parts(choices, "Appendicular")
    end

    def sub_parts(choices, skelpart)
        choice = "Compare"
        until choice != "Compare" do
            choice = @prompt.select("What would you like to see?".light_red.bold, choices)
            if choice != "Compare" && choice != "Main Species Select".light_black
                @api.image_get(@species, "#{choice.gsub(/\s+/, "+")}", @group)
            elsif choice == "Main Species Select".light_black
                main
            else
                species_get(true)
                @api.image_get(@species_second, "#{skelpart}+Skeleton", @group_second)
                puts "\nYou're still in the #{@species} #{skelpart} Skeleton.".light_red.bold
            end
        end
        final_choice = [
            {name: "Return"},
            {name: "Exit", disabled: "(not allowed)"}
        ]
        if skelpart == "Axial"
            axial
        elsif skelpart == "Appendicular"
            appendicular
        end
    end

    def axial
        puts "\n___________________________________________________".cyan
        puts "\n            #{@species.upcase} AXIAL SKELETON               ".bold
        puts "___________________________________________________".cyan
        puts "\n"
        @api.image_get(@species, "Axial+Skeleton", @group)
        number = @api.bone_count(@species, "Axial+Skeleton", @group)
        puts "\n___________________________________________________".cyan
        puts "You're in the #{@species} Axial Skeleton!"
        puts "\nA #{@species} Axial Skeleton has a total of" if @species != "Horse"
        puts "#{number} bones." if @species != "Horse"
        puts "\nThese bones are separated into two main parts:"
        puts "the Skull and everything else."
        puts "\nYou can choose to look at a skull image, compare"
        puts "with another animal's image, or pick a new animal."
        puts "___________________________________________________\n".cyan
        choices = [
            "Skull",
            "Compare",
            "Main Species Select".light_black
        ]
        sub_parts(choices, "Axial")
    end

end