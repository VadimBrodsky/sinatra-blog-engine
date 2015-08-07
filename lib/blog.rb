require 'sinatra/base'
require 'ostruct'
require 'yaml'
require 'time'

class Blog < Sinatra::Base
  # generate absolute path
  set :root, File.expand_path('../../', __FILE__)
  set :articles, []
  set :app_file, __FILE__

  # loop through all articles
  Dir.glob "#{root}/articles/*.md" do |file|
    # parse metadata and content
    meta, content = File.read(file).split("\n\n", 2)

    # generate a metadata object
    article = OpenStruct.new YAML.load(meta)

    # convert the date to a time object
    article.content = Time.parse article.date.to_s

    # add the content
    article.content = content

    # generate the slug
    article.slug = File.basename(file, '.md')

    # add article to list of articles
    articles << article

    # set up the article route
    get "/#{article.slug}" do
      erb :post, locals: { article: article }
    end
  end

  # sort articles by date, new first
  articles.sort_by! { |article| article.date }
  articles.reverse!

  get '/' do
    erb :index
  end

  get '/js/jquery.js' do
    send_file File.join(settings.public_folder, "/bower_components/jquery/dist/jquery.min.js")
  end

  get '/js/jquery.timeago.js' do
    send_file File.join(settings.public_folder, "/bower_components/jquery-timeago/jquery.timeago.js")
  end
end
