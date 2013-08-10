require 'spec_helper'

describe "ActsAsChattable" do
  before do
    User.acts_as_chattable
    @message = send_message
  end

  describe "send messages" do
    it "alice should have one message" do
      @alice.messages.count.should == 1
    end

    it "alice should have one message from bob" do
      @alice.messages.are_from(@bob).count.should == 1
    end

    it "bob should have one message" do
      @bob.messages.count.should == 1
    end

    it "bob should have one message to alice in outbox" do
      @bob.sent_messages.are_to(@alice).count.should == 1
    end

    it "bob should have one open message from alice" do
      @alice.messages.are_from(@bob).process { |m| m.open }
      @alice.messages.readed.count.should == 1
    end
  end

  describe "send messages with bang" do
    it "should return message object" do
      @alice.send_message!(@bob, :body => "body", :attachment => "test").should 
        be_kind_of ActsAsChattable::Message
    end
  end

  describe "inheritance models" do
    it "men send message to alice" do
      send_message(@men, @alice)
      @men.sent_messages.size.should be_equal(1)
      @alice.received_messages.size.should be_equal(2)
    end

    it "messages method should receive all messages connected with user" do
      send_message(@men, @alice)
      @men.messages.size.should be_equal(1)
    end

    it "men send message and receive from alice" do
      send_message(@men, @alice)
      send_message(@alice, @men)

      @men.messages.size.should be_equal(2)
      @men.sent_messages.size.should be_equal(1)
      @men.received_messages.size.should be_equal(1)
    end
  end

  describe "delete messages" do

    it "bob should have one deleted message from alice" do
      @bob.messages.process do |m|
        m.delete
      end

      @bob.messages.each do |m|
        m.recipient_delete.should == true
        m.sender_delete.should == false
      end

      @bob.deleted_messages.count.should == 1
      @bob.messages.count.should == 0
    end

    it "received_messages and sent_messages should work with .process method" do
      @bob.sent_messages.count.should == 1
      @alice.received_messages.count.should == 1

      @bob.sent_messages.process { |m| m.delete }
      @bob.sent_messages.count.should == 0
      @alice.received_messages.count.should == 1

      @alice.received_messages.process { |m| m.delete }
      @alice.received_messages.count.should == 0
    end

    it "message should permanent delete" do
      @alice.messages.process { |m| m.delete }
      @alice.messages.count.should == 0

      @alice.deleted_messages.count.should == 1
      @alice.deleted_messages.process { |m| m.delete }
      @alice.deleted_messages.count.should == 0

      @message.reload
      @message.recipient_permanent_delete.should == true

      @bob.sent_messages.count.should == 1
    end

    it "pat should not able to delete message" do
      lambda { @pat.delete_message(@message) }.should raise_error
    end
  end

  describe "restore message" do
    it "alice should restore message" do
      @alice.received_messages.process { |m| m.delete }
      @alice.restore_message(@message.reload)
      @alice.received_messages.count.should == 1
    end

    it "should works with relation" do
      @alice.received_messages.process { |m| m.delete }
      @alice.received_messages.count.should == 0
      @alice.deleted_messages.process { |m| m.restore }
      @alice.received_messages.count.should == 1
    end

    it "pat should not able to restore message" do
      lambda { @pat.restore_message(@message) }.should raise_error
    end
  end

  describe "read/unread feature" do
    it "alice should have one unread message from bob" do
      @alice.messages.are_from(@bob).unreaded.count.should == 1
      @alice.messages.are_from(@bob).readed.count.should == 0
    end

    it "alice should able to read message from bob" do
      @alice.messages.are_from(@bob).first.read
      @alice.messages.are_from(@bob).unreaded.count.should == 0
    end

    it "alice should able to unread message from bob" do
      @alice.messages.are_from(@bob).first.read
      @alice.messages.are_from(@bob).first.unread
      @alice.messages.are_from(@bob).unreaded.count.should == 1
    end

    it "alice should able to get datetime when he read bob message" do
      @alice.messages.are_from(@bob).first.read
      read_datetime = @alice.messages.are_from(@bob).first.updated_at
      @alice.messages.are_from(@bob).reorder("updated_at asc").first.updated_at.should == read_datetime
    end
  end

  it "finds proper message" do
    @bob.messages.find(@message.id) == @message
  end

  it "message should have proper body" do
    @bob.messages.count.should == 1
    @bob.messages.first.body == "Body"
  end

  describe "conversation" do
    it "bob send message to alice, and alice reply to bob message and show proper tree" do
      @alice.send_message(@bob, "Re: Body")
      @alice.messages_with(@bob).size.should eq(2)
      @alice.messages_with(@bob).last.body.should == "Body"
      @alice.messages_with(@bob).first.body.should == "Re: Body"
      @bob.messages_with(@alice).size.should eq(2)
    end

  #   it "bob send message to alice, alice answer, and bob answer for alice answer" do
  #     @reply_message = @alice.reply_to(@message, "Re: Topic", "Body")
  #     @reply_reply_message = @bob.reply_to(@reply_message, "Re: Re: Topic", "Body")

  #     [@message, @reply_message, @reply_reply_message].each do |m|
  #       m.conversation.size.should == 3
  #     end

  #     @message.conversation.first.should == @reply_reply_message
  #     @reply_reply_message.conversation.first.should == @reply_reply_message
  #   end
  end

  # describe "conversations" do
  #   before do
  #     @reply_message = @message.reply("Re: Topic", "Body")
  #     @reply_reply_message = @reply_message.reply("Re: Re: Topic", "Body")
  #   end

  #   it "bob send message to alice and alice reply" do
  #     @bob.messages.conversations.should == [@reply_reply_message]
  #     @reply_message.conversation.should == [@reply_reply_message, @reply_message, @message]
  #   end

  #   it "show conversations in proper order" do
  #     @sec_message = @bob.send_message(@alice, "Hi", "Alice!")
  #     @sec_reply = @sec_message.reply("Re: Hi", "Fine!")
  #     @bob.received_messages.conversations.map(&:id).should == [@sec_reply.id, @reply_reply_message.id]
  #     @sec_reply.conversation.to_a.should == [@sec_reply, @sec_message]
  #   end
  # end

  # describe "search text from messages" do
  #   before do
  #     @reply_message = @message.reply("Re: Topic", "Body : I am fine")
  #     @reply_reply_message = @reply_message.reply("Re: Re: Topic", "Fine too")
  #   end

  #   it "bob should be able to search text from messages" do
  #     recordset = @bob.messages.search("I am fine")
  #     recordset.count.should == 1
  #     recordset.should_not be_nil
  #   end
  # end

  # describe "send messages with hash" do
  #   it "send message with hash" do
  #     @message = @bob.send_message(@alice, {:body => "Body", :topic => "Topic"})
  #     @message.topic.should == "Topic"
  #     @message.body.should == "Body"
  #   end
  # end

  it "messages should return in right order :created_at" do
    @message = send_message(@bob, @alice, "Example", "Example Body")
    @alice.messages.last.body.should == "Body"
  end

  it "received_messages should return unloaded messages" do
    @alice.received_messages.loaded?.should be_false
  end

  it "sent_messages should return unloaded messages" do
    @bob.sent_messages.loaded?.should be_false
  end

  describe "send messages between two different models (the same id)" do
    it "should have the same id" do
      @alice.id.should be_equal(@admin.id)
    end

    it "bob send message to admin (different model) with the same id" do
      @bob.send_message(@alice, "hello", "alice")
      @alice.messages.are_to(@alice).size.should be_equal(2)
      @alice.messages.are_to(@admin).size.should be_equal(0)
    end

    it "admin send message to bob" do
      @admin.send_message(@bob, "hello", "bob")
      @bob.messages.are_from(@admin).size.should be_equal(1)
      @bob.messages.are_from(@alice).size.should be_equal(0)
    end
  end

end
