class CommentsController < ApplicationController

  def create
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    if @comment.save
      redirect_to photo_path(@photo)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end

end
