# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MultiDoc::Application.initialize!
DataMapper.finalize