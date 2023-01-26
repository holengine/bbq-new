class ApplicationMailer < ActionMailer::Base
  default from: ENV["MJ_SENDER"]
  layout "mailer"
end
