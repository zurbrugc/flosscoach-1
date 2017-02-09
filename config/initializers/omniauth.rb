Rails.application.config.middleware.use OmniAuth::Builder do

    provider :facebook, "#{Rails.application.secrets.FACEBOOK_ID}", "#{Rails.application.secrets.FACEBOOK_KEY}",
    :scope => "email, public_profile"
    provider :twitter, "#{Rails.application.secrets.TWITTER_ID}", "#{Rails.application.secrets.TWITTER_KEY}"
    provider :github, "#{Rails.application.secrets.GITHUB_ID}", "#{Rails.application.secrets.GITHUB_KEY}"

end
