
# Seed Database with admin user(nado)
Member.create!(
  email: 'admin@gignado.com',
  password: 'adminado',
  first_name: 'Admin',
  last_name: 'Nado',
  activated_at: Time.now)
