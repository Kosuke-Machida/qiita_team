require 'rails_helper'

describe Contact do
  it "is valid with a username, slack_name, email and password"
  it "is invalid without a firstname"
  # 姓がなければ無効な状態であること
  it "is invalid without a lastname"
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address"
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address"
  # 連絡先のフルネームを文字列として返すこと
  it "returns a contact's full name as a string"
end
