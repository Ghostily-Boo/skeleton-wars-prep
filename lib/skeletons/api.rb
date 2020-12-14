class API

    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    def image_get(animal, part, group)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:#{group}AnatomyData"
        api = JSON.load(open(url))
        array = api.values[0]["pods"]
        path = ["src", "img", "subpods"]
        puts search_image(array, path)
    end

    def plaintext_get(animal, part, group)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=ConstitutionalParts:#{group}AnatomyData&includepodid=HierarchyRelationships:#{group}AnatomyData&podstate=100@More&format=plaintext"
        api = JSON.load(open(url))
        array = api.values[0]["pods"]
        path = ["subpods", "plaintext"]
        list = array[1] ? search(array[1], path).split(" | ") : search(array[0], path).split(" | ")
    end

    def search(input, path)
        count = 0
        while count <= path.length - 1
            if input.class == Array
                input[0] == path[count] ? (input = input[1]) && (count += 1) : input = input[0]
            elsif input.class == Hash
                input = input[path[count]]
                count += 1
            end
        end
        input
    end

    def search_image(input, path)
        input.each do |a|
            if a.class == Hash
                path.drop(1).each do |keyword|
                    return search_image(a[keyword], path) if a[keyword]
                end
            elsif a.class == Array
                return a[1] if a[0] == path[0]
                search_image(a, path)
            end
        end
    end

end