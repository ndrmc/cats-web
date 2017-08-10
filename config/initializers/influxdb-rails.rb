InfluxDB::Rails.configure do |config|
  config.influxdb_database = "cats_log"
  config.influxdb_username = ENV["INFLUX_USER"]
  config.influxdb_password = ENV["INFLUX_PASSWORD"]
  config.influxdb_hosts    = ENV["INFLUX_CATS_SERVER"]
  config.influxdb_port     = 8086

  config.series_name_for_controller_runtimes = "rails.controller"
  config.series_name_for_view_runtimes       = "rails.view"
  config.series_name_for_db_runtimes         = "rails.db"
end
