class API

    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    def image_get(animal, part, group)
        url = FullSkel.attr_search(animal, :url)
        file = FullSkel.attr_search(animal, :file)
        if !url
            input = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:#{group}AnatomyData"
            api = JSON.load(open(input))
            trail = ["subpods", "img", "src"]
            url = search(api, trail)
            file = open(url).path
            FullSkel.add_attr(animal, url: url, file: file)
        end
        Catpix::print_image file, limit_y: 0.5, resolution: "high"
        puts "\nClick the URL to open a better image:".cyan.on_red
        puts url.red
    end

    def plaintext_get(animal, part, group)
        list = FullSkel.attr_search(animal, :list)
        if !list
            url = BASE_URL + "&input=#{animal}+#{part}&includepodid=ConstitutionalParts:#{group}AnatomyData&includepodid=HierarchyRelationships:#{group}AnatomyData&podstate=100@More&format=plaintext"
            api = JSON.load(open(url))
            trail = ["subpods", "plaintext"]
            list = search(api, trail).split(" | ")
            FullSkel.add_attr(animal, list: list)
        end
        list
    end

    def bone_count(animal, part, group)
        count = FullSkel.attr_search(animal, :count)
        if !count
            count = plaintext_get(animal, part, group).length
            FullSkel.add_attr(animal, count: count)
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