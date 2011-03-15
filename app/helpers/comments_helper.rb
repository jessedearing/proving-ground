require 'digest/md5'

module CommentsHelper
  include ReCaptcha::ViewHelper
  def gravatar_url(email)
    email.downcase!
    hash = Digest::MD5.hexdigest(email)

    "http://gravatar.com/avatar/#{hash}"
  end
end
