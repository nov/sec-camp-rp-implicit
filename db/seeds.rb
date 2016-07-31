# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

case Rails.env
when 'production'
  Client.create(
    identifier: 'a27052c127be1edcd5b815ad91a22ea2',
    secret: 'b3ef8cc42fee95ffbee0a5278c725739be5f54cc52451e3105b96ed351c56811',
    redirect_uri: 'https://sec-camp-rp-implicit.herokuapp.com/callback',
    authorization_endpoint: 'https://sec-camp-idp.herokuapp.com/authorizations/new',
    token_endpoint: 'https://sec-camp-idp.herokuapp.com/tokens',
    userinfo_endpoint: 'https://sec-camp-idp.herokuapp.com/user_info'
  )
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