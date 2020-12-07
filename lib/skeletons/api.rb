
class API

    require 'json'
    require 'pry'
    require 'open-uri'


    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    def image_get(animal, part)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:AnimalAnatomyData&format=image"
        @image = JSON.load(open(url))
    end

    def plaintext_get(animal, part)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=ConstitutionalParts:AnimalAnatomyData&includepodid=HierarchyRelationships:AnimalAnatomyData&podstate=100@More&format=plaintext"
        @result = JSON.load(open(url))
    end

    def organize()
        # iterate over list
        # find common words from right to left
        # create category if none
        # add to category count
    end

end