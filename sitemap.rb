def generate_sitemap_sort array

    files , dirs = [] , []
    array.delete(".")
    array.delete("..")
    array.delete(".git")
    array.each do |a|
        if a.include? "."
            files.push(a)
        else
            dirs.push(a)
        end
    end
    files , dirs = files.sort , dirs.sort

    return dirs+files

end

def generate_sitemap_travel repo , spacing , extra_spacing, text

    list = generate_sitemap_sort(Dir.entries(repo))
    list.each do |l|
        if l.include? "."
            if l == list.last
                text = text + "\n" + spacing + l + "\n"
            elsif l == list.first
                text = text + "\n\n" + spacing + l
            else
                text = text + "\n" + spacing + l
            end    
        else
            if l == list.first
                text = text + "\n\n" + spacing + l +"/"
            else
                text = text + "\n" + spacing + l +"/"
            end
            text = generate_sitemap_travel(repo+"/"+l,spacing+extra_spacing,extra_spacing,text)
        end
    end

    return text

end

def generate_sitemap

    text = "<h1><u> SITEMAP </u></h1> \n<pre>"
    text = text + generate_sitemap_travel(".","","      ","")
    text = text + "</pre>"
    File.open($sitemap, "w") { |file| file.write(text) }

end

$sitemap = "SITEMAP.md"
generate_sitemap()