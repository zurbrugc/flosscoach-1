Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "536873056515793", "2c3cce29072082ed57a3d07fc9f25623",
    :scope => "email, public_profile"

    provider :twitter, "1sa3tuMYEN7iUcEm3pkvNnGwm", "a3SyrLVL8W4X8sA653lLSdFjssifOmlJbFMNsLGIVszlEBCsaI"

    provider :github, "aed2636dcc89e690eb67", "d1215edd5f83d84f1e5c1492dfbd6b6b04c1f33a"


end