class PhotosController < ApplicationController

  before_action :authenticate_user!, only: [ :new, :create, :update, :edit, :update, :destroy ]
  before_action :set_photo, only: [ :show, :edit, :update, :destroy ]

  def index
    @photos = Photo.includes(:user)
  end

  def show
    @photo = Photo.find(params[:id])
    @comment = Comment.new
    @comments = @photo.comments
    @photo_exif = MiniExiftool.new(@photo.image.file.file)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    @photo.save
    redirect_to photos_url @photo
  end

  def edit
  end

  def update
    @photo.update(photo_params)
    redirect_to photos_url @photo
  end

  def destroy
    @photo.destroy
    redirect_to photos_url
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :image, :remove_image, :user_id)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end
end

