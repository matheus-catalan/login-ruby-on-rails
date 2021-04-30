class AddTokeForgotPasswordToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :token_forgot_password, :string
    add_column :users, :date_forgot_password, :date
  end
end
