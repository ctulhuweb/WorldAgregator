namespace :db do
  task dump: :environment do
    cmd = nil
    with_config do |app, host, db, user|
      cmd = "pg_dump -h #{host} -U #{user} -v -F c -d #{db} -f #{Rails.root}/db/#{app}.psql"
    end
    puts cmd
    exec cmd 
  end

  task pgpass: :environment do
    pg_pass
  end

  private

  def pg_pass
    filepath = "#{Rails.root}/db/.pgpass.conf"
    cmd = "touch #{filepath}; echo 'localhost:5432:WorldAgregator_development:pguser:kedP97IBP' > #{Rails.root}/db/.pgpass.conf"
    puts cmd
    exec cmd
  end

  def with_config
    yield(Rails.application.class.parent_name.underscore,
          "localhost",
          Rails.configuration.database_configuration[Rails.env]["database"],
          Rails.application.credentials[Rails.env.to_sym][:base_user])
  end
end