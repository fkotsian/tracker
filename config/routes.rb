Rails.application.routes.draw do
  root to: 'messages#send_message'
  get '/send', to: 'messages#send_message'
end
