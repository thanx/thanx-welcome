# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load pow environment variables into development and test environments
if File.exist?(".powenv")
  IO.foreach('.powenv') do |line|
    next if !line.include?('export') || line.blank?
    key, value = line.gsub('export','').split('=',2)
    ENV[key.strip] = value.delete('"\'').strip
  end
end if Rails.env.development? || Rails.env.test?

# Initialize the Rails application.
Rails.application.initialize!
