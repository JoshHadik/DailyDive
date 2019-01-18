Rails.application.routes.draw do
  root 'scenes/app#my_journals'

  scope '/resources', module: :resources, as: 'resource' do
    devise_for :users

    resources :questions
    resources :journals
  end

  scope module: :scenes, as: 'scenes' do
    get 'journals/:id', to: 'app#journal', as: 'journal'
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
