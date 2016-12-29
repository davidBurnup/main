log_file = File.open("#{Worship::Application.config.root}/log/debug.log", "a")
log_file.sync = true
AppLogger = ActiveSupport::Logger.new(log_file)
AppLogger.level = Logger::DEBUG
AppLogger.debug "AppLogger Up"
