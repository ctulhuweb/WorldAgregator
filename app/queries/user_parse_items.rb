class UserParseItems
  def self.call(user, aggregator_id = nil, relation = ParseItem.all)
    relation = relation
      .includes(site: [aggregator: :user])
      .where(users: { id: user.id })
      .order(:status)

    relation = relation.where(aggregators: { id: aggregator_id }) if aggregator_id.present?
    relation
  end
end