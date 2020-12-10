class CLI

    def initialize
        puts "Brush up on your skeleton knowledge!"
        @@prompt = TTY::Prompt.new
        API.new.image_get(species_get, "skeleton")
    end

    def species_get
        choices = {Dog: 1, Horse: 2, Human: 3}
        value = @@prompt.select("Which species would you like to learn more about?", choices)
        choices.keys[value-1].to_s
    end
    
    def part_get(part, list)
        @@prompt.select("These are the components of #{part}.\nWould you like to see more details?", list)
    end

end