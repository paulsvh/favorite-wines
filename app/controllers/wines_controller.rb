class WinesController < ApplicationController

  def index
    @wines = Wine.reverse_sort
  end

  def show
    @wine = Wine.find_by(id: params[:id])
  end

  def new
    @wine = Wine.new
  end

  def create
     @wine = Wine.find_or_create_by(wine_params)
     @wine.creator_id = current_user.id
    if @wine.valid?
      @wine.name = @wine.full_name
      @wine.save
      redirect_to @wine
    else
      render :new
    end
  end

  def edit
    @wine = Wine.find_by(id: params[:id])
  end

  def update
    @wine = Wine.find_by(id: params[:id])
      @wine.update(wine_params)
      redirect_to @wine
  end

  def filter
    @wines = Wine.reverse_sort.popularity

    render :index
    end

    def category_filter

      @wines = Wine.where(category: params[:category])

      render :index

    end

  private


  def wine_params
      params.require(:wine).permit(:label, :category, :grape, :year, :region)
  end

end
