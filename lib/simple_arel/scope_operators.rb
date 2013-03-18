module SimpleArel
  module ScopeOperators
    def and(other)
      left,right,scope = binary_scope other
      scope.where_values = [left.and(right)]
      scope
    end
    alias_method :&, :and

  private
    def binary_scope(other)
      left  = self.arel.constraints.reduce(:and)
      right = other.arel.constraints.reduce(:and)
      scope = merge(other)
      [left,right,scope]
    end
  end
end