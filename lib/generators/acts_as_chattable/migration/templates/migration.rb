class CreateMessagesTable < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
      t.text :body
      t.string :attachment
      t.references :received_messageable, :polymorphic => true
      t.references :sent_messageable, :polymorphic => true
      t.boolean :opened, :default => false
      t.boolean :recipient_delete, :default => false
      t.boolean :sender_delete, :default => false
      t.timestamps
    end

    add_index :<%= table_name %>, [:sent_messageable_id, :received_messageable_id], :name => "acts_as_chattable_ids"
  end

  def self.down
    drop_table :<%= table_name %>
  end
end
