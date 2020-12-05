require 'json'
require 'pry'
require 'open-uri'

class API
    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    binding.pry
    # def call
    #     url = BASE_URL + "/species"
    # end

end