Rails.application.routes.draw do
  root 'scenes/my_journals#scene'

  devise_for :users

  scope '/resources', module: :resources, as: 'resource' do
    resources :journals
    resources :questions
    resources :responses
    resources :entries
  end

  scope module: :scenes, as: 'scenes' do
    get 'journal/:id', to: 'journal#scene', as: 'journal'
    post 'journal/:id/add_question/',
         to: 'journal#add_question',
         as: 'journal_add_question'

    get 'journal/:id/go', to: 'active_journal#scene', as: 'active_journal'
    post 'journal/:id/go/next_question/',
         to: 'active_journal#next_question',
         as: 'active_journal_next_question'
    post 'journal/:id/go/previous_question/',
        to: 'active_journal#previous_question',
        as: 'active_journal_previous_question'

    get 'journal/:id/entry/:entry_id', to: 'journal_entry#scene', as: 'journal_entry'
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
