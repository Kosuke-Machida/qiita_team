require 'slack'

Slack.configure do |config|
  config.token = ENV['QIITA_TEAM_SLACK_ACCESS_TOKEN']
end
