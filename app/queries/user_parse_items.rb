class UserParseItems
  def self.call(user, relation = ParseItem.all)
    relation
      .includes(site: :user)
      .where(users: { id: user.id })
      .order(:status)
  end
end