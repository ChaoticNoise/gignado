
# Seed Database with admin (nado)
Member.create!(
  email: 'gignado@chaoticnoise.com',
  password: Devise.friendly_token[0,20],
  first_name: 'Admin',
  last_name: 'Nado',
  activated_at: Time.now)

# Seed with band members as of 9/28/2016
members = [
  {e: 'tyson[dot]lynn[at]gmail[dot]com', f: 'Tyson', l: 'Lynn'},
  {e: 'lukekoval[at]gmail[dot]com', f: 'Luke', l: 'Koval'},
  {e: 'ladydank[at]gmail[dot]com', f: 'Shayleen', l: 'Bowling'},
  {e: 'jeanettedubois[at]gmail[dot]com', f: 'Jeanette', l: 'Dubois'},
  {e: 'fluxfnord[at]gmail[dot]com', f: 'Faith', l: 'Rutherford'},
  {e: 'lindsayfmorrison[at]gmail[dot]com', f: 'Lindsay', l: 'Morrison'},
  {e: 'emilysmith777[at]gmail[dot]com', f: 'Emily', l: 'Smith'},
  {e: 'liz[dot]currey[dot]tennis[at]gmail[dot]com', f: 'Liz', l: 'Currey'},
  {e: 'cvonseggern[at]live[dot]com', f: 'Chris', l: 'Von Seggern'},
  {e: 'unklefugly[at]gmail[dot]com', f: 'Joel', l: 'Kenworthy'},
  {e: 'benmelvinbrooks[at]gmail[dot]com', f: 'Ben', l: 'Brooks'},
  {e: 'cagedpoetry[at]gmail[dot]com', f: 'Charli', l: 'Gross' },
  {e: 'thrakazog[at]gmail[dot]com', f: 'Cevin', l: 'Millstead'},
  {e: 'claire[dot]luke[at]gmail[dot]com', f: 'Claire', l: 'Luke'},
  {e: 'drchase[at]gmail[dot]com', f: 'Dave', l: 'Chase'},
  {e: 'lbenito678[at]gmail[dot]com', f: 'Luis', l: 'Benito'},
  {e: 'erob92[at]gmail[dot]com', f: 'Ethan', l: 'Robb'},
  {e: 'raleighmostov[at]gmail[dot]com', f: 'Raleigh', l: 'Mostov'},
  {e: 'kendra[dot]frazer[at]gmail[dot]com', f: 'Kendra', l: 'Frazer'},
  {e: 'randelslug[at]gmail[dot]com', f: 'Randel', l: 'Ludwig'},
  {e: 'mattiemuhoo[at]gmail[dot]com', f: 'Mattie', l: 'Kleczka'},
  {e: 'dvantuyl[at]gmail[dot]com', f: 'Dwight', l: 'VanTuyl'},
  {e: 'spowell1632[at]gmail[dot]com', f: 'Steve', l: 'Powell'},
  {e: 'tcj789[at]gmail[dot]com', f: 'Tracy', l: 'johnson'},
  {e: 'scbloom65[at]gmail[dot]com', f: 'Scott', l: 'bloom'},
  {e: 'skyjohn33[at]gmail[dot]com', f: 'Skylar', l: 'Johnson'},
  {e: 'sensei[dot]taco[at]gmail[dot]com', f: 'Grant', l: 'Kindt'},
  {e: 'heyaqueous[at]gmail[dot]com', f: 'Harry', l: 'Snyder'},
  {e: 'michael[dot]antares[at]gmail[dot]com', f: 'Michael', l: 'Antares'},
  {e: 'mkleinhaus[at]gmail[dot]com', f: 'Mark', l: 'Kleinhaus'},
  {e: 'deechristoff[at]hotmail[dot]com', f: 'Dee', l: 'Christoff'},
  {e: 'zephyrtrp[at]gmail[dot]com', f: 'Zephyr', l: 'Tjerne'},
  {e: 'rray001[at]gmail[dot]com', f: 'Rebecca', l: 'Ray'},
  {e: 'band[at]chaoticnoise[dot]com', f: 'CNMC', l: 'Admin'}
]

members.each do |m|
  Member.create(
    email: m[:e].gsub('[at]', '@').gsub('[dot]', '.'),
    password: Devise.friendly_token[0,20],
    first_name: m[:f],
    last_name: m[:l],
    activated_at: Time.now
  )
end
