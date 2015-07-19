require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yaml"

RSpec::Core::RakeTask.new(:spec)

task :setup do
  require "mysql2"
  config = YAML.load_file('./config.yml')
  options = config["mysql"]
  schema = File.read('./schema/schema.sql')

  @client = Mysql2::Client.new(:host => options["host"], 
                               :username => options["username"],
                               :password => options["password"],
                               :port => options["port"],
                               :database => options["database"],
                               :encoding => "utf8")
  @client.query(schema)
end

task :default => :spec
