class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def destroy
  end

  def bookmark_params
    params[:bookmark][:movie_id] = params[:bookmark][:movie]
    params[:bookmark][:list_id] = params[:list_id]
    params.require(:bookmark).permit(:movie_id, :list_id, :comment)
  end

end
