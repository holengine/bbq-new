class PhotoPolicy < ApplicationPolicy
  def create?
    user.user.present?
  end

  def destroy?
    user_is_owner_event? || user_is_owner_photo?
  end

  private

  def user_is_owner_event?
    user.user.present? && (record.try(:event).user == user.user)
  end

  def user_is_owner_photo?
    user.user.present? && (record.try(:user_id) == user.user.id)
  end
end
