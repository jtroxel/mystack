# See https://github.com/rosenfeld/active_record_migrations
# rake db:migrate db=development

class CreateRestaurant < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :rating
    end
  end
end
