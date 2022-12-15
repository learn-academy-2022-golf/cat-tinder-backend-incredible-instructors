class CatsController < ApplicationController

  # GET /index  
  def index
    cats = Cat.all
    render json: cats
  end

  # POST /create
  def create
    cat = Cat.create(cat_params)
    render json: cat
  end

  # PATCH /update
  def update
    cat = Cat.find(params[:id])
    cat.update(cat_params)
    render json: cat
  end

  # DELETE /destroy
  def destroy
    cat = Cat.find(params[:id])
    if cat.destroy
      render json: cat
    else
      render errors: 'Cat was not destroyed'
    end

  end

  private
  def cat_params
    params.require(:cat).permit(:name, :age, :enjoys, :image)
  end
end
