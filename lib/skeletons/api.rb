class API

    BASE_URL = "http://api.wolframalpha.com/v2/query?output=JSON&appid=#{ENV['AUTH']}"

    def image_get(animal, part, group = "")
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=BodyLocation:#{group}AnatomyData"
        image = JSON.load(open(url))
        path = ["src", "img", "subpods"]
        picture = result(image, path)
        #Catpix::print_image open(picture)
        # magic = Magick::Image.from_blob(open(picture).read)
        # binding.pry
        # magic[0].each_pixel do |pixel, col, row|
        #     c = [pixel.red, pixel.green, pixel.blue].map {|v| 255 * v / 65535.0}
        #     print " ".bg c
        #     puts if col >= 53
        # end
    end

    def plaintext_get(animal, part, group = "")
        url = BASE_URL + "&input=#{animal}+#{part}&includepodid=ConstitutionalParts:#{group}AnatomyData&includepodid=HierarchyRelationships:#{group}AnatomyData&podstate=100@More&format=plaintext"
        @result = JSON.load(open(url))
        binding.pry
    end

    def result(api, path)
        array = api.values[0]["pods"]
        result = search(array, path)
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