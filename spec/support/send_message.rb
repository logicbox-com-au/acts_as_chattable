def send_message(from=@bob, to=@alice, attachment="Topic", body="Body")
  from.send_message(to, body, attachment)
end
