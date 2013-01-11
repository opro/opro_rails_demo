# We are over-riding the Opro controller to provide our own view on new and create
class Oauth::ClientAppsController < Opro::Oauth::ClientAppController

  def new
    @suggest_name = generate_app_name!
    super
  end

  private

  def generate_app_name!
    suggest_name = ["flying", "happy", "bright", "shining", "radiant", "brilliant", "fast"].sample
    suggest_name << "-" << ["samurai", "ninja", "cloud", "sea", "ocean", "foo", "sunset", "sunrise"].sample
    suggest_name << "-" << rand(10000).to_s
  end

end