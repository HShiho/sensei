class Public::InquiriesController < ApplicationController

  def new
    @inquiry = Inquiry.new
    @user = @current_user
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    @user = @current_user
    if @inquiry.invalid?
      render :new
    end
    if params[:inquiry][:mail_number] == "1"
        @inquiry.reply_mail = @current_user.email
    elsif params[:inquiry][:mail_number] == "2"
        @inquiry.reply_mail = params[:inquiry][:reply_mail]
    else
      redirect_to new_public_inquiry_path
    end
  end

  def back
    @inquiry = Inquiry.new(inquiry_params)
    @user = @current_user
    render :new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      redirect_to public_mail_done_path
    else
      render :new
    end
  end

  def mail_done
  end


private

 def inquiry_params
   params.require(:inquiry).permit(:user_id, :subject, :reply_mail, :body)
 end

end
