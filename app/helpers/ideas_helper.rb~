module IdeasHelper
  def full_name(owner)
    @user = User.where(email: owner).first.name
    @user.empty? ? owner : @user
  end
end
