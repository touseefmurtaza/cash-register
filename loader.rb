$LOAD_PATH.push __dir__

require "byebug"
Dir["views/**/*.rb"].each { |file| require file }
Dir["lib/**/*.rb"].each { |file| require file }
Dir["models/**/*.rb"].each { |file| require file }
