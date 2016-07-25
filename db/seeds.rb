# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

case Rails.env
when 'production'
  # TODO
  raise 'register your client'
when 'development'
  Client.create(
    identifier: 'ec427a44c1076c0653a48f6162b044d6',
    secret: '932692979933e82156199ea051564e1914809af3255f35b82cae0cf016d6c69f',
    redirect_uri: 'http://sec-rp-implicit.dev/callback',
    authorization_endpoint: 'http://sec-idp.dev/authorizations/new',
    token_endpoint: 'http://sec-idp.dev/tokens',
    userinfo_endpoint: 'http://sec-idp.dev/user_info'
  )
end