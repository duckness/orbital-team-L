feed_options = {
  language: "en-US"
}
atom_feed feed_options do |feed|
  feed.title "Cluttered | Vectors"
  feed.updated @posts.maximum(:created_at)
  @posts.each do |post|
    feed_entry_options = {
      published: post.created_at, 
      updated:   post.updated_at
    }
    feed.entry post, feed_entry_options do |entry|
      entry.title post.title
      entry.content "#{image_tag(image_url(post.vector.url(:thumb)))}<br />#{post.description}", :type => "html"
      entry.author do |author|
        author.name post.user_id
      end
      entry.url post_url(post)
    end
  end
end
