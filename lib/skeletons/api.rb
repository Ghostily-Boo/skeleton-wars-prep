class API

    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    def image_get(animal, part)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:AnimalAnatomyData"
        image = JSON.load(open(url))
        binding.pry
        result(image, "src")
    end

    def plaintext_get(animal, part)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=ConstitutionalParts:AnimalAnatomyData&includepodid=HierarchyRelationships:AnimalAnatomyData&podstate=100@More&format=plaintext"
        @result = JSON.load(open(url))
        binding.pry
    end

    def result(hash, word)
        array = hash.values[0]["pods"]
        array.each do |a|
            if a.class == Hash
                hash["src"] || hash["img"] || hash["subpods"]
            end
        end
    end

end