class User < ActiveRecord::Base
  acts_as_chattable
end

class Men < User
end
