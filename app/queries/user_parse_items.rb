class UserParseItems
  def self.call(user, relation = ParseItem.all)
    relation
      .includes(site: [aggregator: :user])
      .where(users: { id: user.id })
      .order(:status)
  end
end