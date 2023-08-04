class FeedsController < ApplicationController
    before_action :set_feed, only: [:show, :edit, :update, :destroy]

    def show
    end

    def index
        @feeds = Feed.all
    end

    def media_purge_later
        media = ActiveStorage::Attachment.find(params[:id])
        media.purge_later
        redirect_back fallback_location: root_path, notice: "Media Deleted"
    end

    def new
        @feed = Feed.new()
    end

    def create
        @feed = Feed.new(feed_params)
        if @feed.save
            flash[:notice] = "Feed has been posted successfully"
            redirect_to @feed
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @feed.update(feed_params)
            flash[:notice] = "Feed has been posted successfully"
            redirect_to @feed
        else
            render 'edit'
        end
    end

    def destroy
        @feed.destroy
        redirect_to feeds_path
    end

    private

    def set_feed
        @feed = Feed.find(params[:id])
    end

    def feed_params
        params.require(:feed).permit(:title, :description, media: [])
    end

end
