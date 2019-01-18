Rails.application.routes.draw do
  root 'scenes/app#my_journals'

  scope '/resources', module: :resources, as: 'resource' do
    devise_for :users

    resources :questions
    resources :journals
  end

  scope module: :scenes, as: 'scenes' do
    get 'journal/:id', to: 'journal#scene', as: 'journal'
    post 'journal/:id/add_question/',
         to: 'journal#add_question',
         as: 'journal_add_question'
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
