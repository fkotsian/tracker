Rails.application.routes.draw do
  post '/', to: 'messages#respond'
  root 'messages#respond'
end
