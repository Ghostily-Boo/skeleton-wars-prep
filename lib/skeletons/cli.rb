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

end