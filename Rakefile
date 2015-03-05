require 'active_record_migrations' # https://github.com/rosenfeld/active_record_migrations

ActiveRecordMigrations.configure do |c|
  # TODO:  factor out config into a Rails style database.yml
  dbconfig = YAML::load(File.open('db/config.yml'))
  c.database_configuration = dbconfig

  # Other settings:
  c.schema_format = :sql # default is :ruby
  # c.yaml_config = 'db/config.yml'
  # c.environment = ENV['db']
  # c.db_dir = 'db'
  # c.migrations_paths = ['db/migrate'] # the first entry will be used by the generator
end

ActiveRecordMigrations.load_tasks
