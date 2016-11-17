class ApplicationMailer < ActionMailer::Base
  default from: ENV['STMP_EMAIL'] || 'from@example.com'
  layout 'mailer'
end
