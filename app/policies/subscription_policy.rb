class SubscriptionPolicy < ApplicationPolicy
  def create?
    true unless user_is_owner_event? && user_subscribed?
  end

  def destroy?
    user_is_owner_event? || user_subscriber?
  end

  private

  def user_is_owner_event?
    user.user.present? && (record.try(:event).user == user.user)
  end

  def user_subscribed?
    user.user.present? && current_user.subscriptions.find_by(event_id: record.try(:event).id).present?
  end

  def user_subscriber?
    user.user.present? && (record.try(:user) == user.user)
  end
end
