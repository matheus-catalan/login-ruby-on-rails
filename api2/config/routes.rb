Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    resource :users, only: [:create, :show, :update]
    get "/index/users", to: "users#index"
    delete "/users/:userId", to: "users#delete"
    post "/login", to: "users#login"
    post "/forgot/password", to: "users#forgotPassword"
    post "/forgot/password/save", to: "users#forgotPasswordSave"
    get "/auth/user", to: "users#validate"
  end
end
