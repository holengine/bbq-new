class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:github]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  has_many :events, dependent: :destroy

  validates :name, presence: true,
                   length: { maximum: 15 },
                   uniqueness: true

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    user ||= User.create(
      email: data['email'],
      password: Devise.friendly_token(16)
    )

    user.name = access_token.info.name
    user.remote_avatar_url = access_token.info.image
    user.provider = access_token.provider
    user.uid = access_token.uid
    user.save

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
