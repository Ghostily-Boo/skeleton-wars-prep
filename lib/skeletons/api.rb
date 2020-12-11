class API

    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=HRT7R3-8HE5552JY2"

    def image_get(animal, part)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:AnimalAnatomyData"
        image = JSON.load(open(url))
        result(image)
    end

    def plaintext_get(animal, part)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=ConstitutionalParts:AnimalAnatomyData&includepodid=HierarchyRelationships:AnimalAnatomyData&podstate=100@More&format=plaintext"
        @result = JSON.load(open(url))
        binding.pry
    end

    def result(hash)
        array = hash.values[0]["pods"]
        path = ["src", "img", "subpods"]
        result = search(array, path)
        binding.pry
    end

    def search(input, path)
        input.each do |a|
            if a.class == Hash
                path.drop(1).each do |keyword|
                    return search(a[keyword], path) if a[keyword]
                end
            elsif a.class == Array
                return a[1] if a[0] == path[0]
                search(a, path)
            end
        end
    end

end