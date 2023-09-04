class MessagesController < ApplicationController
    def index
        @users = User.all
        @messages = Message.all
    end

    def create
        @message = Message.new(message_params)
        @message.user = current_user
        if @message.save
            ActionCable.server.broadcast "chatroom_channel", {mod_msg: message_render(@message)}
        else
            flash[:alert] = "Comment can't be empty."
            redirect_to messages_path
        end
    end

    private

    def message_params
        params.require(:message).permit(:body)
    end
    
    def message_render(message)
        render(partial: 'messages/message', locals: {message: message})
    end
end