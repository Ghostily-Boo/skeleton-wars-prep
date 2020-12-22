class API

    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    def image_get(animal, part, group)
        url = FullSkel.attr_search(animal, part, :url)
        if !url
            input = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:#{group}AnatomyData"
            api = JSON.load(open(input))
            trail = ["subpods", "img", "src"]
            url = search(api, trail)
            FullSkel.add_attr(animal, part, url: url)
        end
        url
    end

    def plaintext_get(animal, part, group)
        list = FullSkel.attr_search(animal, part, :list)
        if !list
            url = BASE_URL + "&input=#{animal}+#{part}&includepodid=ConstitutionalParts:#{group}AnatomyData&includepodid=HierarchyRelationships:#{group}AnatomyData&podstate=100@More&format=plaintext"
            api = JSON.load(open(url))
            trail = ["subpods", "plaintext"]
            list = search(api, trail).split(" | ")
        end
        list
    end

    def bone_count(animal, part, group)
        count = FullSkel.attr_search(animal, part, :count)
        if !count
            if part == "Skeleton"
                url = BASE_URL + "&input=#{animal}+bone+count&includepodid=Result&format=plaintext"
                api = JSON.load(open(url))
                trail = ["subpods", "plaintext"]
                count = search(api, trail)
                FullSkel.add_attr(animal, part, count: count)
            else
                count = plaintext_get(animal, part, group).length
                FullSkel.add_attr(animal, part, count: count)
            end
        end
        count
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