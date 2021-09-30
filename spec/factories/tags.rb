FactoryBot.define do
  factory :tag do
    name { SecureRandom.hex 8 }
    user
  end
end
