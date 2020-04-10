require "open-uri"
class Parser
  @logger = Logger.new("log/parser.log")

  class << self
    def get_data_for_all_sites(sites)
      @logger.debug("run get_data_for_all_sites(sites) Count sites: #{sites.size}")
      sites.each do |s|
        data = get_data(s)
        @logger.debug(site.info)
        @logger.debug("Parse data: #{data}")
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
      doc = Nokogiri::HTML(open(site.url))
      items = doc.css(site.main_selector).map do |b|
        fetch(b, site.parse_fields)
      end
    rescue => error
      @logger.debug(site.info)
      @logger.debug(error)
    end

    def fetch(block, parse_fields)
      data = {}
      parse_fields.each do |pf|
        if pf.field_type == "custom"
          data.merge!({ "#{pf.name}": block.css(pf.selector)[0].content })
        else
          data.merge!({ 
            "#{pf.name}": { 
              value: block.css(pf.selector)[0]["href"], 
              type: "link"} 
          })
        end
      end
      data
    end
  end
end