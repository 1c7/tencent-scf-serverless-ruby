require 'sinatra'

set :port, 9000
set :bind, '0.0.0.0'

get '/' do
  '根页面!'
end

get '/*' do
  '捕捉全部页面!'
end