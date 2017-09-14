FactoryGirl.define do
  factory :role do
    title 1
    event nil
    member nil
  end

  factory :member do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    activated_at { Time.now() }
    pwd = Faker::Internet.password(8)
    date_joined '1/2/2016'
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

  factory :rehearsal, parent: :event, class: 'Rehearsal' do
    title { Faker::Name.name }
    association :rehearsal_pic, factory: :member
  end

  factory :promotion do
    title { Faker::Lorem.sentence }
    url { Faker::Internet.url }
    time_display { Faker::Lorem.sentence }
    location_display {Faker::Address.street_address}
    location_url { Faker::Internet.url }
    association :event, factory: :event
  end
end
