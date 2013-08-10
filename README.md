ActsAsChattable
=================

The Acts As Chattable allows communication between models. 

It was designed for a mobile app that needs private communications with attachments, like the iPhone SMS app for example.

[![Build Status](https://secure.travis-ci.org/LTe/acts-as-messageable.png)](http://travis-ci.org/LTe/acts-as-messageable)
[![Dependency Status](https://gemnasium.com/LTe/acts-as-messageable.png)](https://gemnasium.com/LTe/acts-as-messageable)
[![Code Climate](https://codeclimate.com/github/LTe/acts-as-messageable.png)](https://codeclimate.com/github/LTe/acts-as-messageable)
[![Coverage Status](https://coveralls.io/repos/LTe/acts-as-messageable/badge.png?branch=master)](https://coveralls.io/r/LTe/acts-as-messageable?branch=master)
[![Gem Version](https://badge.fury.io/rb/acts-as-messageable.png)](http://badge.fury.io/rb/acts-as-messageable)

Usage
=====

To use it, add it to your Gemfile:

### Rails 3 & 4

```ruby
gem 'acts_as_chattable'
```

Post instalation
================

```
rails g acts_as_chattable:migration
rake db:migrate
```

Usage
=====

```ruby
class User < ActiveRecord::Base
  acts_as_chattable :required   => :body                  # default [:body]
                    :dependent  => :destroy               # default :nullify
end
```

Send message
============

```ruby
@alice = User.first
@bob   = User.last

@alice.send_message(@bob, "Hi bob!")
@bob.send_message(@alice, Hi alice!")
```

## With hash

```ruby
@alice.send_message(@bob, { :body => "Hash body" })
```

Custom required (validation)
============================

In User model

```ruby
class User < ActiveRecord::Base
  acts_as_chattable :required => :body
end
```

## With hash

```ruby
@alice.send_message(@bob, { :body => "Hash body" })
```

## Normal

```ruby
@alice.send_message(@bob, "body")
```

Conversation
============

You can get conversation list from messages scope. For example:

```ruby
@message = @alice.send_message(@bob, "Hello bob!", "How are you?")
@reply_message = @bob.reply_to(@message, "Re: Hello bob!", "I'm fine!")

@alice.received_messages.conversations # => [@reply_message]
```

should receive list of latest messages in conversations (like in facebook).

To create conversation just reply to a message.

```ruby
@message = @alice.send_message(@bob, "Hello bob!", "How are you?")
@message.reply("Re: Hello bob!", "I'm fine")
```

**Or with hash**

```ruby
@message.reply(:topic => "Re: Hello bob!", :body => "I'm fine")
```

**Or in old style**

```ruby
@message = @alice.send_message(@bob, "Hello bob!", "How are you?")
@reply_message = @bob.reply_to(@message, "Re: Hello bob!", "I'm fine!")
```

## Get conversation for a specific message

```ruby
@message.conversation       #=> [@message, @reply_message]
@reply_message.conversation #=> [@message, @reply_message]
```

Search
======

You can search text from messages and get the records where match exist. For example:

### Search text from messages

```ruby
records = @alice.messages.search("Search me")  @alice seach text "Search me" from all messages
```

### Inbox
```ruby
@alice.received_messages
```

### Outbox
```ruby
@alice.sent_messages
```
### Inbox + Outbox. All messages connected with __@alice__
```ruby
@alice.messages
```

### Trash
```ruby
@alice.deleted_messages
```

## Filters
==========

```ruby
@alice.messages.are_from(@bob) # all message form @bob
@alice.messages.are_to(@bob) # all message to @bob
@alice.messages.with_id(@id_of_message) # message with id id_of_message
@alice.messages.readed # all readed @alice  messages
@alice.messages.unreaded # all unreaded @alice messages
```


**You can use multiple filters at the same time**

```ruby
@alice.messages.are_from(@bob).are_to(@alice).readed # all message from @bob to @alice and readed
@alice.deleted_messages.are_from(@bob) # all deleted messages from @bob
```

Read messages
=============

### Read message

```ruby
@message.open # open message
@message.read
@message.mark_as_read
```

### Unread message

```ruby
@message.close # unread message
@message.mark_as_unread
```


Delete message
==============

**__We must know who delete message. That why we use *.process* method to save context__**

```ruby
@message = @alice.send_message(@bob, "Topic", "Body")

@alice.messages.process do |message|
  message.delete # @alice delete message
end
```

Now we can find message in **trash**

```ruby
@alice.deleted_messages #=> [@message]
```

We can delete the message **permanently**

```ruby
@alice.deleted_messages.process do |message|
  message.delete
end

@alice.delete_message #=> []
```

Message has been deleted **permanently**

## Delete message without context

```ruby
@alice.delete_message(@message) # @alice delete @message
```

Restore message
===============

```ruby
@alice.deleted_messages.process do |m|
  m.restore # @alice restore 'm' message from trash
end
```

## Restore message without context

```ruby
@alice.restore_message(@message) # @alice restore message from trash
```


Search
======

## Search text from messages

```ruby
@alice.messages.search("Search me")  @alice seach text "Search me" from all messages
```

Copyright © 2013 Ben Bruscella, released under the MIT license
