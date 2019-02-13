Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth"
  }

  scope '/resources', module: :resources, as: 'resource' do
    resources :journals, only: [:update, :destroy]
    resources :questions, only: [:update, :destroy]
    resources :responses, only: [:update, :destroy]
    resources :entries, only: [:update, :destroy]
  end

  # Scenes
  scope module: :scenes, as: 'scenes' do
    get '/', to: 'current_journal#scene', as: 'current_journal'
    get 'auth', to: 'auth#scene', as: 'auth'
    get 'go', to: 'active_journal#scene', as: 'active_journal'
    get 'entry/:id', to: 'journal_entry#scene', as: 'journal_entry'
  end

  # action_add_question_to_current_journal_path
  # Actions
  scope module: :scenes, as: 'actions' do
    post 'sign_out', to: 'base#sign_out_action', as: 'sign_out'

    scope '/current_journal', controller: :current_journal do
      post :add_question, as: 'add_question'
      put :update_account, as: 'update_account'
      put :update_password, as: 'update_password'
      put :delete_account, as: 'delete_account'
      post 'delete_question/:id', action: 'delete_question', as: 'delete_question'
    end

    scope '/auth', controller: :auth do
      post :login, as: 'login'
      post :signup, as: 'signup'
    end

    scope '/go', controller: :active_journal do
      post :next, as: 'next_question'
      post :previous, as: 'previous_question'
    end

    scope '/entry/:id', controller: :journal_entry do
      post :delete_entry, as: 'delete_entry'
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
