Rails.application.routes.draw do
  # root to: 'messages#send_message'
  post '/in', to: 'messages#respond'
end
