require 'json'
require 'pry'
require 'open-uri'

class API
    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    def image_get(animal, part)
        # base url + podid "BodyLocation:AnimalAnatomyData" + subpod "img src"
        # animal_part = 
    end

    def plaintext_get(animal, part)
        # BASE_URL + 
        # "&input=#{animal}+#{part}+skeleton&podstate=100@ConstitutionalParts:AnimalAnatomyData__More"
        # convert into list
        # organize()
    end

    def organize()
        # iterate over list
        # find common words from right to left
        # create category if none
        # add to category count
    end

end