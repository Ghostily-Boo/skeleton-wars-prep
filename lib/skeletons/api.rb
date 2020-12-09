require 'dotenv/load'


class API

    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    def initialize(animal, part)
        image_get(animal, part)
        plaintext_get(animal, part)
        #or just organize(animal, part)
    end

    def image_get(animal, part)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:AnimalAnatomyData&format=image"
        @image = JSON.load(open(url))
    end

    def plaintext_get(animal, part)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=ConstitutionalParts:AnimalAnatomyData&includepodid=HierarchyRelationships:AnimalAnatomyData&podstate=100@More&format=plaintext"
        @result = JSON.load(open(url))
        binding.pry
    end

    def organize()
        #attach @image and @result to hash
        #@result should be cleaned up
    end

end