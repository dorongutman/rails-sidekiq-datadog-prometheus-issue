#CHANGED_BY_ME
require 'sidekiq/api'
require 'prometheus_exporter/instrumentation'


$LOAD_PATH << Rails.root

  Sidekiq.configure_server do |config|
    config.server_middleware do |chain|
        chain.add PrometheusExporter::Instrumentation::Sidekiq
    end
      config.death_handlers << PrometheusExporter::Instrumentation::Sidekiq.death_handler
    config.on :startup do
      PrometheusExporter::Instrumentation::SidekiqQueue.start
      PrometheusExporter::Instrumentation::Process.start type: 'sidekiq'
    end
    at_exit do
      PrometheusExporter::Client.default.stop(wait_timeout_seconds: 10)
    end
end


