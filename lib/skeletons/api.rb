class API

    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    def image_get(animal, part, group)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:#{group}AnatomyData"
        api = JSON.load(open(url))
        path = ["subpods", "img", "src"]
        puts search(api, path)
    end

    def plaintext_get(animal, part, group)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=ConstitutionalParts:#{group}AnatomyData&includepodid=HierarchyRelationships:#{group}AnatomyData&podstate=100@More&format=plaintext"
        api = JSON.load(open(url))
        path = ["subpods", "plaintext"]
        list = search(api, path).split(" | ")
    end

    def search(input, path)
        input = input.values[0]["pods"]
        input[1] ? input = input[1] : input = input[0]
        count = 0
        while count <= path.length - 1
            if input.class == Array
                input[1] if input[0] == path.last
                input[0] == path[count] ? (input = input[1]) && (count += 1) : input = input[0]
            elsif input.class == Hash
                input = input[path[count]]
                count += 1
            end
        end
        input
    end

end