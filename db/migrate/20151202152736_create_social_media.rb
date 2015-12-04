class CreateSocialMedia < ActiveRecord::Migration
  def change
    create_table :social_media do |t|
      t.references :user, index: true, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :secret
      t.string :display
      t.string :token
      t.date :token_expires_at
      t.timestamps
    end
  end
end
