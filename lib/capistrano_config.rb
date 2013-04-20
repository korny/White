# Source: http://gist.github.com/2769

Capistrano::Configuration.instance.load do
  config_files = {
    'database.yml'    => 'config/database.yml',
    'secret_token.rb' => 'config/initializers/secret_token.rb',
  }
  
  namespace :config do
    desc 'Create the configuration files in shared path.'
    task :setup, :except => { :no_release => true } do
      run "mkdir -p #{shared_path}/config"
      for source, target in config_files
        put File.read("config/deploy/#{source}"), "#{shared_path}/config/#{source}"
      end
    end
    
    desc 'Update the symlinks for config files to the just deployed release.'
    task :symlinks, :except => { :no_release => true } do
      for source, target in config_files
        run "ln -nfs #{shared_path}/config/#{source} #{release_path}/#{target}"
      end
    end
  end
  
  after "deploy:setup",           "config:setup"
  after "deploy:finalize_update", "config:symlinks"
end
