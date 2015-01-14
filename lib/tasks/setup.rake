namespace :white do
  desc 'Create an empty first page and set the admin password.'
  task :setup => :environment do
    print "#{User.admin ? 'reset' : 'enter'} admin password: "
    password = $stdin.gets.chomp
    
    if password.present?
      admin = User.admin || User.new(email: 'admin')
      admin.password = password
      admin.save!
    else
      abort 'Empty password, aborting.'
    end
    
    unless Section.welcome_section
      puts 'Creating first section...'
      Section.create!(title: 'Home') unless Section.exists?
      
      puts 'Creating first page...'
      Section.first.pages.create!(title: 'Example Page', text: <<-MARKDOWN)
Welcome to your White website!

Start by logging in with your password by moving the cursor to the upper right corner of the page.

You can:

- Add sections and pages in the sidebar
- Edit text by clicking into the page
- Add pictures by dragging them into the page
      MARKDOWN
    end
    
    puts 'Done.'
  end
end
