module Api
    class MessagesController < ApplicationController
        
        def index
            @users = User.all
            render json: @users
        end
        def hello
            @user_msg = [] 
            @users = User.all
            @messages = Message.all

            @messages.each do |message|
                hah ={username: User.find(message.user_id).username}
               @user_msg.push(hah)
            end
            
            render json: { users: @users, messages: @messages, currentuser: current_user }
        end

        def create
            @message = Message.new(message_params)
            @message.user = current_user
            if @message.save
                ActionCable.server.broadcast "chatroom_channel", mod_msg: @message
                render json: @message, status: :ok
              else
                render json: @message.errors.full_messages, status: :unprocessable_entity
            end
        end

        private

        def message_params
            params.require(:message).permit(:body)
        end
        
    end
end