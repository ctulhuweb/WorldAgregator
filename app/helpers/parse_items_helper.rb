module ParseItemsHelper
  def parse_item_link_to(pi)
    data = pi.link_data
    if data.present?
      key = data.keys.first
      link_to key, data[key]["value"]
    end
  end
end
