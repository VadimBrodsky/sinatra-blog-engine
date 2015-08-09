# ./.git/hooks/post-receive

#!/usr/bin/env ruby
require 'open-uri'

# app Post URL
open('http://localhost:9292/update')
