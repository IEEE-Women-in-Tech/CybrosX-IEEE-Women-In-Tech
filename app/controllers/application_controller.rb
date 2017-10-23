class ApplicationController < ActionController::Base

  helper_method :check_frozen_status
  protect_from_forgery with: :exception
  before_filter :check_frozen_status
  before_filter :notify_new_message

  def not_authenticated
    flash[:warning] = 'You must be signed in to access this page.'
    redirect_to sign_in_path
  end

  def check_frozen_status
    if current_user && current_user.is_frozen && !current_user.is_admin
      logout
    else
      true
    end
  end

  def notify_new_message
    if current_user && current_user.incoming_messages.unread.unseen.any?
      current_user.incoming_messages.unread.unseen.map(&:seen!)
      flash[:success] = "You have new messages."
    end
  end

end
