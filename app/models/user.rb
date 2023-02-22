class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:github, :google_oauth2]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  has_many :events, dependent: :destroy

  validates :name, presence: true,
                   length: { maximum: 25 },
                   uniqueness: true

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(access_token)
    user = User.where(email: access_token.info.email).first

    user ||= User.create(
      email: access_token.info.email,
      password: Devise.friendly_token(16),
      name: access_token.info.name,
      remote_avatar_url: access_token.info.image,
      provider: access_token.provider,
      uid: access_token.uid
    )

    user
  end

  private

  def set_name
    self.name = "User №#{rand(1000)}" if name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email).update_all(user_id: id)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
