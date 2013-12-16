database_yaml = YAML::load(File.read("#{Rails.root}/config/mongoid.yml"))
puts "Initializing mongodb"

mongo_database = database_yaml[Rails.env]['sessions']['default']
MongoMapper.connection = Mongo::Connection.new(mongo_database['host'], 27017)
MongoMapper.database =  mongo_database['database']