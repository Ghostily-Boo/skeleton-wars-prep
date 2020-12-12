class API

    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    def image_get(animal, part, group)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:#{group}AnatomyData"
        api = JSON.load(open(url))
        array = api.values[0]["pods"]
        path = ["src", "img", "subpods"]
        search_image(array, path)
    end

    def plaintext_get(animal, part, group)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=ConstitutionalParts:#{group}AnatomyData&includepodid=HierarchyRelationships:#{group}AnatomyData&podstate=100@More&format=plaintext"
        api = JSON.load(open(url))
        array = api.values[0]["pods"]
        path = ["plaintext", "subpods"]
        array[1] ? search_text(array[1], path) : search_text(array[0], path)
    end

    def result(api, path)
        array = api.values[0]["pods"]
        array[1] ? result = search(array.drop(1), path) : result = search(array, path)
    end

    def search_text(input, path)
        if input[path[0]]
            return seach(input[path[0]]) 
        else
            path.drop(1).each do |keyword|

    end

    def search_image(input, path)
        input.each do |a|
            binding.pry
            if a.class == Hash
                path.drop(1).each do |keyword|
                    binding.pry
                    return search(a[keyword], path) if a[keyword]
                end
            elsif a.class == Array
                return a[1] if a[0] == path[0]
                search(a, path)
            end
        end
    end

end