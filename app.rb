require 'sinatra'
require 'soda'
require 'dotenv'

Dotenv.load

configure do
  # Sinatra
  set :root, File.dirname(__FILE__)
  set :public_folder, Proc.new { File.join(root, 'static') }
  set :views, Proc.new { File.join(root, 'templates') }

  # Variables
  set :app_token, ENV['SOCRATA_APP_TOKEN']
  set :dataset, '5wce-bks2'
end

# Socrata client
portal = SODA::Client.new({domain: 'data.cityofchicago.org', app_token: settings.app_token})

get '/' do
  erb :index
end

get '/search' do
  @query = params['q']
  @results = portal.get settings.dataset, {"$q" => @query}
  erb :search
end

# UPC no longer exists
# get '/detail/:upc' do
#   @product = portal.get(settings.dataset, {"UPC" => params[:upc]}).first
#   erb :detail
# end