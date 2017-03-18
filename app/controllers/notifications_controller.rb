class NotificationsController < ApplicationController
  def index
    assign_notifications
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to post_path @notification.post
  end

  def toggle_read
    @dropdown = params[:dropdown]
    @notification = Notification.find(params[:id])
    @notification.read = !@notification.read
    @notification.save
    assign_notifications
    respond_to do |format|
      format.html { redirect_back fallback_location: root_url }
      format.js
    end
  end

  private

  def assign_notifications
    @unread_notifications = current_user.notifications.unread
                                        .page(params[:unread_page]).per(3)
    @read_notifications = current_user.notifications.read
                                      .page(params[:read_page]).per(3)
  end
end
