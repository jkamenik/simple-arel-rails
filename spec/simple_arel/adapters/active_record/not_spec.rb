require 'spec_helper'

describe SimpleArel::ScopeOperators do
  context '.not' do
    context 'with singlar clauses' do
      it 'should join them with "AND NOT"' do
        relation = (User.where(:name => 'john') - User.where(:name => 'doe'))
        relation.to_sql.should match /WHERE \(+"users"."name" = 'john'\) AND \(NOT \("users"."name" = 'doe'\)\)+/
      end
    end

    context 'with compound clauses' do
      it 'should join them with "AND NOT"' do
        relation = (User.where(:name => 'john', :title => 'CEO') - User.where(:name => 'doe', :title => 'COO'))
        relation.to_sql.should match /WHERE \(\("users"."name" = 'john' AND "users"."title" = 'CEO'\)\) AND \(NOT \(\("users"."name" = 'doe' AND "users"."title" = 'COO'\)\)\)/
      end
    end

    context 'with chained clauses' do
      sql = (User.where(:name => 1) | User.where(:name => 2) | User.where(:name => 3)).to_sql
      sql.should =~ /WHERE \(+"user"."name" = 1 OR "user"."name" = 2 OR "user"."name" = 3\)+/
    end
  end
end