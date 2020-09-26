require 'test_helper'

class CodeOfConductTest < ActiveSupport::TestCase

  def setup
    @code_of_conduct = code_of_conducts(:one)
  end

  test '#repository' do
    assert_equal 'MyString', @code_of_conduct.repository.name
  end

  test '#code_of_conduct_type' do
    assert_equal 'MyString', @code_of_conduct.code_of_conduct_type.name
  end
end
