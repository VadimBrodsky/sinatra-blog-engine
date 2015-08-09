$LOAD_PATH.unshift 'lib'
require 'blog'

if ENV['URL'] and ENV['DATABASE_URL']
  # we are on Heroku, no cache needed`
  # read-only file system
  GithubHook.disable :autopull
elsif Blog.production?
  # require 'rack/cache'
  # use Rack::Cache
end

run Blog
