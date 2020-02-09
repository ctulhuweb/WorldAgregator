class TestWorker
  include Sidekiq::Worker

  def perform(params)
    @logger = Logger.new("log/test_worker.log")
    @logger.debug("lya kakoi test with params: #{params}")
  end
end