class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user 
      items = user.items
      else 
        return render json: {error: "404 Not Found"}, status: :not_found
      end
    else
      items = Item.all
    end
    render json: items, include: :user 
  end

  def show
    user = User.find_by!(id: params[:user_id])
    if user 
      item = user.items.find_by(id: params[:id])
    else
      return render json: { error: "404 Not Found" }, status: :not_found
    end
    render json: item, include: :user
  end

  def create
    user = User.find_by(id: params[:user_id])
    if user
      new_item = Item.create(
        name: params[:name],
        description: params[:description],
        price: params[:price],
        user_id: params[:user_id]
      )
      render json: new_item, status: :created
    else
      render json: { error: "404 Not Found" }, status: :not_found
    end
  end





end
