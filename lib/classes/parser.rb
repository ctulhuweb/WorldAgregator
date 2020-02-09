require "open-uri"
class Parser
  @loger = Logger.new("log/parser.log")

  class << self
    def get_data_for_all_sites(sites)
      sites.each do |s|
        data = get_data(s)
        if data.present?
          data.each do |item|
            if ParseItem.where("data->>'Title' = ?", item[:Title]).count == 0
              pi = s.parse_items.create(data: item, status: :new)
              NotificationChannelWorker.perform_async(pi.id)
            end
          end
        end
      end
    end

    def get_data(site)
      return unless site.active?
      doc = Nokogiri::HTML(open(site.url)) rescue return
      items = doc.css(site.main_selector).map do |b|
        fetch(b, site.parse_fields)
      end
    end

    def fetch(block, parse_fields)
      data = {}
      parse_fields.each do |pf|
        data.merge!({ "#{pf.name}": block.css(pf.selector)[0].content })
      end
      data
    end
  end
end