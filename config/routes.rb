Rails.application.routes.draw do
  get 'game', to: 'longestwordgame#game'
  get 'score', to: 'longestwordgame#score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end



