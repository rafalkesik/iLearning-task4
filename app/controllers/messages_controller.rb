class MessagesController < ApplicationController
  def create
    element_id = "message_#{SecureRandom.hex(4)}"
    ai_answer  = GroqClient.chat(params[:message])
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append('messages',
                              partial: 'users/question_and_answer',
                              locals: { message:    params[:message],
                                        ai_answer:  ai_answer,
                                        element_id: element_id }),
          turbo_stream.replace('message-input',
                               partial: 'users/chat_input_element'),
          turbo_stream.action(:focus, element_id)
        ]
      end
    end    
  end
end