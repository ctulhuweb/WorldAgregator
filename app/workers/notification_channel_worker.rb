class NotificationChannelWorker
  include Sidekiq::Worker

  def perform(parse_item_id)
    pi = ParseItem.find(parse_item_id)
    broadcast_params = {
      channel: "notification_channel",
      content: ParseItemsController.render(template: "parse_items/_parse_item", locals: { parse_item: pi}, layout: false)
    } 
    ActionCable.server.broadcast("notification_channel",
                                 content: ParseItemsController.render(template: "parse_items/_parse_item", locals: { parse_item: pi}, layout: false))
  end
end