class API

    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    def image_get(animal, part, group)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:#{group}AnatomyData"
        api = JSON.load(open(url))
        trail = ["subpods", "img", "src"]
        file = open(search(api, trail)).path
        Catpix::print_image "#{file}", limit_x: 0.5, resolution: "high"
    end

    def plaintext_get(animal, part, group)
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=ConstitutionalParts:#{group}AnatomyData&includepodid=HierarchyRelationships:#{group}AnatomyData&podstate=100@More&format=plaintext"
        api = JSON.load(open(url))
        trail = ["subpods", "plaintext"]
        list = search(api, trail).split(" | ")
    end

    def search(input, trail)
        input = input.values[0]["pods"]
        input[1] ? input = input[1] : input = input[0]
        count = 0
        while count <= trail.length - 1
            if input.class == Array
                input[1] if input[0] == trail.last
                input[0] == trail[count] ? (input = input[1]) && (count += 1) : input = input[0]
            elsif input.class == Hash
                input = input[trail[count]]
                count += 1
            end
        end
        input
    end

end