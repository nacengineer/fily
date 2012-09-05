MultiDoc::Application.routes.draw do

  scope '/multidoc/' do
    resources :documents, :only => [:index, :create, :destroy] do
      collection do
        get 'result',      :to => "documents#result"
      end
    end
    # Users
    devise_scope :user do
      get 'sign_in' => redirect('/multidoc/users/auth/ecourts'), :as => :new_user_session
      if Rails.env.development?
        get 'developer_sign_in' => redirect('/multidoc/users/auth/developer'), :as => :new_developer_session
      end
      get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
    end
    match 'status' => "public#index"
  end
  devise_for :users, :path => "/multidoc/users", :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match '/multidoc/' => "documents#new"

  root :to => "documents#new"

end
