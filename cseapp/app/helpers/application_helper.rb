module ApplicationHelper
    def avatar_url_for(user, size: 150)
      email_hash = Digest::MD5.hexdigest(user.email.strip.downcase)
      "https://www.gravatar.com/avatar/#{email_hash}?s=#{size}&d=identicon"
    end
  end