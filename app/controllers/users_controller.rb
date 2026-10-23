class UsersController < ApplicationController
  before_action :set_bulk_users, only: %i[bulk_destroy bulk_block bulk_unblock]

  def index
    @users = User.order(:id)
  end

  def bulk_destroy
    @bulk_users.destroy_all
    flash[:success] = "Users deleted successfully"
    redirect_to users_path
  end

  def bulk_block
    @bulk_users.update_all(status: 'blocked')
    flash[:success] = "Users blocked successfully"
    redirect_to users_path
  end

  def bulk_unblock
    @bulk_users.update_all(status: 'active')
    flash[:success] = "Users unblocked successfully"
    redirect_to users_path
  end

  private
  
    def set_bulk_users
      if params[:user_ids].blank?
        redirect_to users_path, alert: 'No users selected.'
      else
        @bulk_users = User.where(id: params[:user_ids])
      end
    end
end
