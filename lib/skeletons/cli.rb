class CLI

    def initialize
        puts "Brush up on your skeleton knowledge!"
        @prompt = TTY::Prompt.new
        species_get
    end

    def species_get
        choices = {Dog: 1, Horse: 2, Human: 3}
        @prompt.select("Which species would you like to learn more about?", choices)
    end
    
    def part_get(part, list)
        @prompt.select("These are the components of #{part}.\nWould you like to see more details?", list)
    end

end