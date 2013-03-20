require 'spec_helper'

describe SimpleArel::ScopeOperators do
  context '.or' do
    context 'with singlar clauses' do
      it 'should join them with "OR"' do
        relation = (User.where(:name => 'john') | User.where(:name => 'doe'))
        relation.to_sql.should match /WHERE \(+"users"."name" = 'john' OR "users"."name" = 'doe'\)+/
      end
    end

    context 'with compound clauses' do
      it 'should join them with "OR"' do
        relation = (User.where(:name => 'john', :title => 'CEO') | User.where(:name => 'doe', :title => 'COO'))
        relation.to_sql.should match /WHERE \(\(\("users"."name" = 'john' AND "users"."title" = 'CEO'\) OR \("users"."name" = 'doe' AND "users"."title" = 'COO'\)\)\)/
      end
    end
  end
end