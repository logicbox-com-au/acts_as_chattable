class CreateMessagesTable < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text :body
      t.string :attachment
      t.references :received_messageable, :polymorphic => true
      t.references :sent_messageable, :polymorphic => true
      t.boolean :opened, :default => false
      t.boolean :recipient_delete, :default => false
      t.boolean :sender_delete, :default => false
      t.timestamps
    end

    add_index :messages, [:sent_messageable_id, :received_messageable_id], :name => "acts_as_chattable_ids"
  end

  def self.down
    drop_table :messages
  end
end
