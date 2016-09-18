Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "#{Rails.application.secrets.FACEBOOK_KEY}", "#{Rails.application.secrets.FACEBOOK_TOKEN}", 
    :scope => "email, public_profile"

    provider :twitter, "#{Rails.application.secrets.TWITTER_KEY}", "#{Rails.application.secrets.TWITTER_TOKEN}"

    provider :github, "#{Rails.application.secrets.GITHUB_KEY}", "#{Rails.application.secrets.GITHUB_TOKEN}"


end