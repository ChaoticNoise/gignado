FactoryGirl.define do
  factory :member do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password Faker::Internet.password(8)
    password_confirmation Faker::Internet.password(8)
  end

  factory :event do
    title { Faker::Lorem.sentence }
    start_time Time.now() + 1.day
    end_time Time.now() + 1.day + 3.hours
    location {Faker::Address.street_address}
  end

  factory :gig, parent: :event, class: 'Gig' do
    title { Faker::Name.name + "'s Wedding" }
  end
end