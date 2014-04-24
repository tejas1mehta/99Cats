class CatRentalRequestsController < ApplicationController
  before_action :ensure_current_user!, only: :update

  def ensure_current_user!
    # redirect_to root_url unless Cat.find(user == current_user)
    redirect_to root_url unless CatRentalRequest.find(params[:id]).user == current_user
  end

  def new
    @cats = Cat.all

    render :new
  end

  def create
    @cat_rent = CatRentalRequest.new(cat_rental_params)
    if @cat_rent.save
      redirect_to cat_url(Cat.find(params[:cat_rental_request][:cat_id]))
    else
      render :plain, @cat_rent.errors.full_messages
    end
  end

  def update
    @cat_rent = CatRentalRequest.find(params[:id])
    if params[:decision] == "approve"
      @cat_rent.approve!
      flash.notice = "Cat Request Approved!"
    else
      @cat_rent.deny!
      flash.notice = "Cat Request Denied!"
    end

    redirect_to :back
  end

  private
  def cat_rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
