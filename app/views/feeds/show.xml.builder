xml.instruct!
xml.rss "version" => "2.0", "xmlns:atom" => 'http://www.w3.org/2005/Atom' do

  xml.channel do
    xml.title @feed_title
    xml.description
    xml.link root_url
    xml.language "en"
    xml.tag! 'atom:link', :rel => 'self', :type => "application/rss+xml", :href => request.original_url.force_encoding("UTF-8")

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.link post.url
        xml.pubDate(post.created_at.rfc2822)
        xml.guid "comet-observatory-#{post.source_id}-#{post.uid}"
        xml.description "From #{post.source.name}#{post.author.present? ? " / By #{post.author}" : nil}"
      end
    end
  end
end
