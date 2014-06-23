class CatsController < ApplicationController

  before_action :ensure_current_user!, only: [:edit, :update]


  def ensure_current_user!
    # redirect_to root_url unless Cat.find(user == current_user)
    redirect_to root_url unless Cat.find(params[:id]).user == current_user
  end

  def index
    @cats = Cat.all
    render :index
  end


  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :plain, @cat.errors.full_messages
    end

  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render :plain, @cat.errors.full_messages
    end
  end


  private

  def cat_params
    params[:cat][:age] = params[:cat][:age].to_i
    params[:cat][:user_id] = params[:cat][:user_id].to_i

    params.require(:cat).permit(:age, :birth_date, :color, :name, :sex, :user_id)
  end

end
