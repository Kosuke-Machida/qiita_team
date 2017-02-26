if Rails.env == 'production'
  ## 本番の定数
else
  SLACK_SHARE_CHANNEL = '#qiita_team_test'.freeze
end
