require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => ':memory:'
)

#ActiveRecord::Base.silence do
#  ActiveRecord::Migration.verbose = false

  ActiveRecord::Schema.define do
    create_table :users, :force => true do |t|
      t.string :name
      t.string :title
      t.integer :company_id
      t.integer :hours_per_week
    end

    create_table :companies, :force => true do |t|
      t.string :name
    end
  end
#end
