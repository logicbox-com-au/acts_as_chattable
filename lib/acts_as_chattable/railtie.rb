require 'active_record/railtie'
require 'active_support/core_ext'

module ActsAsChattable
  class Railtie < Rails::Railtie
    if defined?(ActiveRecord::Base)
      ActiveRecord::Base.send :include, ActsAsChattable::Model
    end

    if defined?(ActiveRecord::Relation)
      ActiveRecord::Relation.send :include, ActsAsChattable::Relation
    end
  end
end
