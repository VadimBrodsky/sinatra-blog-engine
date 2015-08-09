require 'sinatra/base'
require 'time'

class GithubHook < Sinatra::Base
  post '/update' do
    app.settings.reset!
    load app.settings.app_file

    content_type :txt
    if settings.autopull?
      # pipe to stdout to make
      `git pull 2>&1`
    else
      "ok"
    end
  end
end
