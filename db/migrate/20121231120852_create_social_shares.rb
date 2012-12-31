class CreateSocialShares < ActiveRecord::Migration
  def self.up
    create_table :social_shares do |t|
      t.string :email
      t.string :sender_mail
      t.string :sender_name
      t.string :name
      t.integer :product_id
      t.timestamps
    end
  end

  def self.down
    drop_table :social_shares
  end
end
