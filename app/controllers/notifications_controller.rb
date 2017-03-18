class NotificationsController < ApplicationController
  def index
    @unread_notifications = current_user.notifications.unread
                                        .page(params[:unread_page]).per(3)
    @read_notifications = current_user.notifications.read
                                      .page(params[:read_page]).per(3)
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to post_path @notification.post
  end
end
