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
    @photo_exifR = Magick::ImageList.new(@photo.image.file.file)
    if @photo_exifR.get_exif_by_entry('GPSLatitude').present? && @photo_exifR.get_exif_by_entry('GPSLongitude').present? && !@photo_exifR.get_exif_by_entry('GPSLatitude')[0][1].nil?
      exif_lat = @photo_exifR.get_exif_by_entry('GPSLatitude')[0][1].split(',').map(&:strip)
      exif_lng = @photo_exifR.get_exif_by_entry('GPSLongitude')[0][1].split(',').map(&:strip)
      @lat = (Rational(exif_lat[0]) + Rational(exif_lat[1])/60 + Rational(exif_lat[2])/3600).to_f
      @lng = (Rational(exif_lng[0]) + Rational(exif_lng[1])/60 + Rational(exif_lng[2])/3600).to_f
      gon.lat = @lat
      gon.lng = @lng
    elsif @photo.spot.present?

      @lat = @photo.spot.latitude
      @lng = @photo.spot.longitude
      gon.lat = @lat
      gon.lng = @lng
    end
  end

  def new
    @photo = Photo.new
    @photo.build_spot
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    if @photo.save
      redirect_to photos_url @photo
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @photo.update(photo_params)
    redirect_to photo_url @photo
  end

  def destroy
    @photo.destroy
    redirect_to photos_url
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :image, :remove_image, :user_id, {category_ids: []}, spot_attributes: [:address])
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end
end

