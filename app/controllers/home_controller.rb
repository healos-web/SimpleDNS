class HomeController < ApplicationControllerBase
  get '/' do
    slim :home
  end
end