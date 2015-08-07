require 'sinatra/base'

class Blog < Sinatra::Base
  # generate absolute path
  set :root, File.expand_path('../../', __FILE__)
end
