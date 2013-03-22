module SimpleArel
  module HashWhere
    def hash_where(matches)
      raise SyntaxError, 'Arguments must be a hash' unless matches.is_a? Hash

      # examples
      #  {:name => 5} -> name = 5
      #  {:name => [{:lt => 50, :gt => 10}, 7]} -> (name < 50 and name > 10) or name = 7
      #  {:name => {:eq => [3,4]}}              -> (name = 3) or name = 4

      clause = matches.map do |attribute, conditions|
        recursive_hash_where(attribute,:eq,conditions)
        #Array.wrap(conditions).map do |predicates|
        #  predicates = predicates.kind_of?(Hash) ? predicates : {eq: predicates}
        #  predicates.map do |predicate, value|
        #    arel_table[attribute].send(predicate, value)
        #  end.reduce(:and)
        #end.reduce(:or)
      end.reduce(:and)
      where(clause)
    end
    alias_method :h_where, :hash_where
    alias_method :hwhere,  :hash_where

  private
    def recursive_hash_where(attribute,predicate,condition)
      puts "#{attribute} #{predicate} #{condition.inspect}"
      return arel_table[attribute].send(predicate,condition) unless condition.is_a?(Hash) || condition.is_a?(Array)

      if condition.is_a? Array
        puts 'array'
        puts condition.inspect
        Arel::Nodes::Grouping.new(condition.map do |value|
          recursive_hash_where(attribute, predicate, value)
        end.reduce(:or))
      else
        Arel::Nodes::Grouping.new(condition.map do |p,value|
          puts predicate.inspect
          puts value.inspect
          recursive_hash_where(attribute,p,value)
        end.reduce(:and))
      end
    end
  end
end