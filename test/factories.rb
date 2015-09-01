FactoryGirl.define do
  factory :member do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    pwd = Faker::Internet.password(8)
    password pwd
    password_confirmation pwd
  end

  factory :event do
    title { Faker::Lorem.sentence }
    start_time Time.now() + 1.day
    end_time Time.now() + 1.day + 3.hours
    location {Faker::Address.street_address}
    data Hash.new
  end

  factory :gig, parent: :event, class: 'Gig' do
    title { Faker::Name.name + "'s Wedding" }
    confirmation_deadline Time.now()
  end
end