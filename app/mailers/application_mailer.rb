class ApplicationMailer < ActionMailer::Base
  default from: ENV['SMTP_EMAIL'] || 'from@example.com'
  layout 'mailer'
end
