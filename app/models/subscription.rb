class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, if: -> { user.present? }

  validate :self_subscription, if: -> { user.present? }
  validate :email_exists, unless: -> { user.present? }

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def self_subscription
    errors.add(:base, :error) if event.user == user
  end

  def email_exists
    errors.add(:base, :email_error) if User.find_by(email: user_email)
  end
end
