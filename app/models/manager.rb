class Manager < User
  has_one :group, dependent: :destroy
end
