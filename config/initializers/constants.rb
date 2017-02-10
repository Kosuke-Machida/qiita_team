if Rails.env == 'production'
  ## 本番の定数
else
  MASTER_GROUP_ID = 1
  SLACK_SHARE_CHANNEL = '#qiita_team_test'
end
