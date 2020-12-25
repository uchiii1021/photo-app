class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @items = PhotoCategory.where(category_id: @category.id)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "登録しました"
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    redirect_to categories_path, notice: "カテゴリー「#{@category.category_name}」を更新しました。"
  end

  def destroy
    @category.destroy
    redirect_to categories_url
  end

  private
  def category_params
    params.require(:category).permit(:category_name, :category_image, photo_ids: [])
  end

end
