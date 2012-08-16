# grab the root
PROJECT_ROOT = File.dirname(__FILE__)

# add directories to load path
$:.unshift File.dirname(__FILE__) + '/classes'

# load modules and classes
Dir["#{PROJECT_ROOT}/classes/*.*"].each do |file|
  require file
end
  