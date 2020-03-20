module UsersHelper
  def avatar_url(user)
    if user.avatar.attached?
      url_for(user.avatar)
    else
      "avatar-undefined.jpg"
    end
  end
end