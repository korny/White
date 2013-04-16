class CreateUsers < ActiveRecord::Migration
  def change
    ActiveRecord::Base.transaction do
      create_table :users do |t|
        t.string :email,           null: false
        t.string :password_digest, null: false
        
        t.index :email, unique: true
        
        t.timestamps
      end
      
      unless reverting?
        $stdout.print 'Please set an admin password: '
        if (password = $stdin.gets.chomp) && password.present?
          User.create! email: 'admin', password: password
        end
      end
    end
  end
end
