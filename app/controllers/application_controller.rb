class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
  end

  get '/' do
    slim :home
  end
end

class ApplicationControllerBase < Sinatra::Base
  def self.inherited(subclass)
    super

    ApplicationController.use subclass
  end
end