# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Cab2::Application.initialize!

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'mseries', 'mserieses'
  inflect.irregular 'series', 'serieses'
end