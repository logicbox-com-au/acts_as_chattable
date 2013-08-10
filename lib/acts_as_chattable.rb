module ActsAsChattable
  autoload :Model,    'acts_as_chattable/model'
  autoload :Message,  'acts_as_chattable/message'
  autoload :Relation, 'acts_as_chattable/relation'
  autoload :Rails3,   'acts_as_chattable/rails3'
  autoload :Rails4,   'acts_as_chattable/rails4'

  def self.rails_api
    if Rails::VERSION::MAJOR >= 4
      Rails4
    else
      Rails3
    end
  end
end

require 'acts_as_chattable/railtie'
