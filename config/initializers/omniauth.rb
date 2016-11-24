Rails.application.config.middleware.use OmniAuth::Builder do

    provider :facebook, "#{Rails.application.secrets.FACEKEY}", "#{Rails.application.secrets.FACETOKEN}",
    :scope => "email, public_profile"

    provider :twitter, "#{Rails.application.secrets.TWITTERKEY}", "#{Rails.application.secrets.TWITTERTOKEN}" 

    provider :github, "#{Rails.application.secrets.GITKEY}", "#{Rails.application.secrets.GITTOKEN}"


end