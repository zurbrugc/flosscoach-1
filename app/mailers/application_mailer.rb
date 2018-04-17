class ApplicationMailer < ActionMailer::Base
  default :from => "noanswer@flosscoach.com"
  layout 'mailer'

  def site_name
    "FLOSSCoach"
  end
  
end
