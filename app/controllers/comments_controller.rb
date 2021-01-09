class CommentsController < ApplicationController

  def create
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    respond_to do |format|
      if @comment.save
        format.html {redirect_to photo_path(@photo)}
        format.js { render :index }
      else
        format.html {redirect_to photo_path(@photo)}
        format.js { render :index }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end

end
