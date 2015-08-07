require 'sinatra/base'
require 'ostruct'
require 'time'

class Blog < Sinatra::Base
  # generate absolute path
  set :root, File.expand_path('../../', __FILE__)

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
    article.slug = Filename.basename(file, '.md')

    # set up the route
    get "/#{article.slug}" do
      erb :post, locals: { article: article }
    end
  end
end
