class AccountsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(params[:account])
    @account.users << current_user
    binding.pry
    if @account.save_with_payment
      redirect_to @account, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @account = Account.find(params[:id])
    if !@account.users.include?(current_user)
      redirect_to root_path, :alert => "Not authorized"
    end
  end

  def edit
    @account = Account.find(params[:id])
    if !@account.users.include?(current_user)
      redirect_to root_path, :alert => "Not authorized"
    end
  end

  def update
    @account = Account.find(params[:id])
    if @account.users.include?(current_user)
      if @account.update_attributes(params[:account])
        redirect_to @account, notice: 'Account was successfully updated.'
      else
        render action: "edit"
      end
    else
      redirect_to root_path, :alert => "Not authorized"
    end
  end

  def destroy
    @account = Account.find(params[:id])
    if @account.users.include?(current_user)
      @account.destroy
      redirect_to root_url
    else
      redirect_to root_path, :alert => "Not authorized"
    end
  end
  
end
