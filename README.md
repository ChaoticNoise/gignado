# Gignado

## Setup Instructions
### Setup Google Auth Environment Variables
1. Find the Client ID and Client Secret values in (for app owner, currently band@chaoticnoise.com "gignado" project)
  -  https://console.developers.google.com
  -  APIs & auth
  -  Credentials
2. Create a file `.ruby-env` in the root of the gignado app.
3. Add the following environment settings to the `.ruby-env` file:
```
GOOGLE_CLIENT_ID=YOUR_GOOGLE_CLIENT_ID
GOOGLE_CLIENT_SECRET=YOUR_GOOGLE_CLIENT_SECRET
```
4. If Google is erring about a non registered redirect url, you'll need to add
the one Google is complaining about to the gignado project in the google developers
console.

## Testing
### Test with Color
Install colordiff in order to allow colors in minitest using the purdytest gem
```
brew install colordiff
```

### Autotest and livereload browser using guard
From the command line, run guard:
```
guard
```

## Login First Time

Seed Database with admin user:
```
bundle exec rake db:seed
```

The database is seeded with the following credentials:
- email: admin@gignado.com
- password: adminado


After logging in, change your admin password by opening:
```
http://localhost:3000/members/edit
```
