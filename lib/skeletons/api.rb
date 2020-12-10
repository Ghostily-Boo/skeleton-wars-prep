class API

    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=HRT7R3-8HE5552JY2"

    def image_get(animal, part)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:AnimalAnatomyData"
        image = JSON.load(open(url))
        binding.pry
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
        
        search(array, path)
    end

    def search(input, path)
        binding.pry
        input.each do |a|
            binding.pry
            if a.class == Hash
                binding.pry
                return a[path[0]] if a[path[0]]
                path.drop(1).each do |keyword|
                    binding.pry
                    search(a[keyword], path) if a[keyword]
                end
            elsif a.class == Array
                search(a, path)
            end
        end
    end

end