xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title "Jesse Dearing | Looping Infinitely"
    xml.link "http://jessedearing.com"
    xml.description "My name is Jesse Dearing and I am a full-stack developer. This is where I write about stuff that interests me."
    xml.language 'en'

    @nodes.each do |node|
      xml.item do
        xml.title node.title
        xml.link "http://jessedearing.com/nodes/#{node.id}"
        xml.description node.teaser
        xml.guid "http://jessedearing.com/nodes/#{node.id}"
      end
    end
  end
end
