module Api
    module V1
     
        class FeedsController < ApplicationController
            protect_from_forgery with: :null_session
            before_action :set_feed, only: [:show, :edit, :update, :destroy]

            def show
                render json: @feed, methods: :has_media?
            end

            def index
                @feeds = Feed.all
                render json: @feeds, methods: :has_media?
            end

            def create
                @feed = Feed.new(feed_params)
                if @feed.save
                    render json: {id: @feed.id}
                else
                    render json: { error: @feed.errors.messages }, status: 422
                end
            end

            def update
                if @feed.update(feed_params)
                    render json: {id: @feed.id}
                else
                    render json: { error: @feed.errors.messages }, status: 422
                end
            end

            def destroy
                if @feed.destroy
                    head :no_content
                else
                    render json: { error: feeds.errors.messages }, status: 422
                end
            end

            private

            def set_feed
                @feed = Feed.find(params[:id])
            end

            def feed_params
                params.require(:feed).permit(:title, :description, media: [])
            end
        end 
    end
end