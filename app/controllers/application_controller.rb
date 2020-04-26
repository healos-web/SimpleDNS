class ApplicationController < Sinatra::Base; end

class ApplicationControllerBase < Sinatra::Base
  register Sinatra::Flash
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
  end
  
  def self.inherited(subclass)
    super

    ApplicationController.use subclass
  end
end