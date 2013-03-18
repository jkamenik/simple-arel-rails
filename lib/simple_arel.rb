require "simple_arel/version"
require 'simple_arel/scope_operators'
require 'simple_arel/h_where'

module SimpleArel
end

require 'active_record'
require 'active_support'

ActiveSupport.on_load :active_record do
  extend SimpleArel::HWhere

  ActiveRecord::Relation.send(:include, SimpleArel::ScopeOperators)
end
