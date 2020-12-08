class CLI

    def initialize
        @@prompt = TTY::Prompt.new
    end

    def self.species_get(choices)
        @@prompt.select("Which species would you like to learn more about?", choices)
    end
    
    def part_get(part, list)
        @@prompt.select("These are the components of #{part}.\nWould you like to see more details?", list)
    end

end