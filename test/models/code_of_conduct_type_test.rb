require 'test_helper'

class CodeOfConductTypeTest < ActiveSupport::TestCase
  def setup
    @code_of_conduct_type = code_of_conduct_types(:one)
  end

  test '#code_of_conducts' do
    assert_equal 'MyString', @code_of_conduct_type.code_of_conducts.first.path
  end
end
