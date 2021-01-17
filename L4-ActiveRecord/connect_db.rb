require "active_record"

# connect to database
def connect_db!
  ActiveRecord::Base.establish_connection(
    host: "localhost",
    adapter: "postgresql",
    database: "saas_db",
    user: "postgres",
    password: "*******",
  )
end
