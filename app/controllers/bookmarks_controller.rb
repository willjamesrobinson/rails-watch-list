class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  # GET /lists/:list_id/bookmarks/new
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  # POST /lists/:list_id/bookmarks
  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_bookmarks_path
  end

  private

  def bookmark_params
    # params = {
    #             bookmark: {
    #               comment: "Great movie",
    #               movie_id: 1
    #             }
    #           }
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
