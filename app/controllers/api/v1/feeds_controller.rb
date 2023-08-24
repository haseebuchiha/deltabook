module Api
    module V1
     
        class FeedsController < ApplicationController
            protect_from_forgery with: :null_session
            before_action :set_feed, only: [:show, :edit, :update, :destroy]

            def show
                render json: @feed.as_json.merge(
                    media: @feed.media.map do |item|
                            item.as_json.merge({link: url_for(item)})
                    end
                )
            end

            def index
                @feeds = Feed.all
                render json: @feeds.map { |feed|
                    feed.as_json.merge(
                        media: feed.media.map do |item|
                            item.as_json.merge({link: url_for(item)})
                        end
                    )
                }
            end

            def media_purge_later
                media = ActiveStorage::Attachment.find(params[:id])
                media.purge_later
                @id = params[:id]
                render json: {id: @id, success: true}
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
                if @feed.update(feed_params.except(:media))
                    media = feed_params[:media]
                    if media
                        media.each do |item|
                            @feed.media.attach(item)
                        end
                    end
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