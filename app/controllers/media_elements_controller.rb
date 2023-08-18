class MediaElementsController < ApplicationController

    def create
        feed = Feed.find(params[:id])
        feed.media_elements.create
    end

end