module SimpleArel
  module ScopeOperators
    def and(other)
      left,right,scope = binary_scope other
      scope.where_values = [left.and(right)]
      scope
    end
    alias_method :&, :and

    def or(other)
      left,right,scope = binary_scope other
      scope.where_values = [left.or(right)]
      scope
    end
    alias_method :|, :or

  private
    def binary_scope(other)
      left  = group_and_reduce self.arel.constraints
      right = group_and_reduce other.arel.constraints
      scope = merge(other)
      [left,right,scope]
    end

    def group_and_reduce(side)
      # just reduce if I am 1 large with no children
      return side.reduce(:and) if side.size <= 1 && side.first.children.size <= 1

      Arel::Nodes::Grouping.new(side.reduce(:and))
    end
  end
end