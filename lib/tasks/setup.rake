namespace :white do
  desc 'Set the admin password.'
  task :setup => :environment do
    print 'Admin password: '
    password = $stdin.gets.chomp
    
    if password.present?
      admin = User.admin || User.new(email: 'admin')
      admin.password = password
      admin.save!
    else
      puts 'Empty password, aborting.'
    end
  end
end
