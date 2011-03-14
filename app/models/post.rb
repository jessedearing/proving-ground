class Post < Node
  def teaser
    if body =~ /\<\!--break--\>/
      return body[0...(body =~ /\<\!--break--\>/)]
    end
    body
  end
end
