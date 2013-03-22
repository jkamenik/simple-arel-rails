require "simple_arel/version"
require 'simple_arel/scope_operators'
require 'simple_arel/hash_where'

require 'active_record'
require 'active_support'

ActiveSupport.on_load :active_record do
  extend SimpleArel::HashWhere

  ActiveRecord::Relation.send(:include, SimpleArel::ScopeOperators)
end