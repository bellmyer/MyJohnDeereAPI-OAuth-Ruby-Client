# Sample uses App with Sandbox access only
# download oauth gem :- sudo gem install oauth
require 'oauth'
require 'json'

API_KEY = ''#API_KEY is the App Id of your app created in develoepr.deere.com
API_SECRET = ''#API_SECRET is the shared secret of your app created in develoepr.deere.com


def getBasicCatalog(token=nil)
consumerForCatalog=OAuth::Consumer.new(API_KEY, API_SECRET)
consumerForCatalog.request(:get, 'https://apicert.soa-proxy.deere.com/platform/', token, {}, {'accept' => 'application/vnd.deere.axiom.v3+json'})
end

def setupLinksForOauth(catalog)
(JSON.parse(catalog.body)['links']).each do |map|
case map['rel']
when 'oauthRequestToken' then
@requestToken_uri = map['uri']
when 'oauthAuthorizeRequestToken' then
@authorizeRequestToken_uri = map['uri']
when 'oauthAccessToken' then
@accessToken_uri = map['uri']
when 'files' then
@files_uri = map['uri']
when 'currentUser' then
@currentUser_uri = map['uri']
end
end
@authorizeRequestToken_uri.sub!("?oauth_token={token}", "")

end

setupLinksForOauth(getBasicCatalog)

#puts @currentUser_uri

consumer=OAuth::Consumer.new API_KEY,
API_SECRET,
{ :site => 'https://apicert.soa-proxy.deere.com',
:header =>{:Accept =>'application/vnd.deere.axiom.v3+json'},
:http_method => :get,
:request_token_url=>@requestToken_uri,
:access_token_url =>@accessToken_uri,
:authorize_url => @authorizeRequestToken_uri
}


puts
puts '***** Fetching request token *****'
request_token=consumer.get_request_token({}, 'oob')
puts "Request Token received - #{request_token.token}"
puts
puts '---> Goto to url mentioned below to authorize and paste the access token verifier'
puts request_token.authorize_url

verifier = gets.chomp
puts
puts
puts '***** Fetching access token *****'
access_token = request_token.get_access_token(:oauth_verifier=>verifier)
puts "Access token received - #{access_token.token}"
puts
puts '***** Fetching user details: GET /users/{userName} *****'
response = access_token.get('/platform/users/SW31759',{ 'accept'=> 'application/vnd.deere.axiom.v3+json' })
puts
puts 'JSON Response'
puts response.body

setupLinksForOauth(getBasicCatalog(access_token))
