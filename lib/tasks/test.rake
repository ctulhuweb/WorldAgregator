namespace :test do
  task worker: :environment do
    TestWorker.perform_async({ best: "ylulu"})
  end

  task notif_worker: :environment do
    NotificationChannelWorker.perform_async(2)
  end
end