require 'digest/md5'

module CommentsHelper
  include ReCaptcha::ViewHelper
  def gravatar_url(email)
    email.downcase!
    hash = Digest::MD5.hexdigest(email)

    "http://gravatar.com/avatar/#{hash}?s=32"
  end

  def comments_path
    "/nodes/#{params[:node_id]}/comments"
  end

  def comment_path(obj)
    "/nodes/#{params[:node_id]}/comments/#{obj.id}"
  end
end
