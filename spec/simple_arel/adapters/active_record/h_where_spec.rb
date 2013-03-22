require 'spec_helper'

describe SimpleArel::HashWhere do
  context '.hwhere' do
    it 'takes a hash of conditions' do
      expect {
        User.hwhere([])
      }.to raise_error, SyntaxError
    end

    context 'with a single value' do
      it 'should compare with =' do
        User.hwhere(:company_id => 0).to_sql.should =~ /WHERE "users"."company_id" = 0/
      end
    end

    context 'with array values' do
      it 'should join them with with OR' do
        User.hwhere(:company_id => [nil,0]).to_sql.should =~ /WHERE \(+"users"."company_id" IS NULL OR "users"."company_id" = 0\)+/
      end

      context 'with hash values' do
        it 'should treat the key as predicate and value as value' do
          User.hwhere(:company_id => [{:gt => 2}]).to_sql.should =~ /WHERE \(+"users"."company_id" > 2\)+/
        end

        it 'should join them with AND' do
          User.hwhere(:company_id => [nil,{:gt => 2, :lteq => 5}]).to_sql.should =~ /WHERE \(+"users"."company_id" IS NULL OR \(+"users"."company_id" > 2 AND "users"."company_id" <= 5\)+/
        end
      end
    end

    context 'with hash values' do
      it 'should treat the key as the predicate and value as value' do
        User.hwhere(:company_id => {:lt => 5}).to_sql.should =~ /WHERE \(+"users"."company_id" < 5\)+/
      end
      it 'should join them with AND' do
        User.hwhere(:company_id => {:lt => 5, :gteq => 2}).to_sql.should =~ /WHERE \(+"users"."company_id" < 5 AND "users"."company_id" >= 2\)+/
      end

      context 'with array values' do
        it 'should join them with OR' do
          User.hwhere(:company_id => {:eq => [1,2,3]}).to_sql.should =~ /WHERE \(+"users"."company_id" = 1 OR "users"."company_id" = 2\)? OR "users"."company_id" = 3\)+/
        end
      end
    end
  end
end