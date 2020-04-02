class UserParseItemsAll
  def self.call(user, relation = ParseItem.all)
    relation
      .joins(site: :user)
      .where(users: { id: user.id })
      .order(:status)
  end
end