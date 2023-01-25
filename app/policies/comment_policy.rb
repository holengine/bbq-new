class CommentPolicy < ApplicationPolicy
  def destroy?
    user_is_owner_event? || user_is_owner_comment?
  end

  private

  def user_is_owner_event?
    user.user.present? && (record.try(:event).user == user.user)
  end

  def user_is_owner_comment?
    user.user.present? && (record.try(:user_id) == user.user.id)
  end
end
