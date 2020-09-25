require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  def setup
    @repository = repositories(:one)
  end

  test '#code_of_conducts' do
    assert_equal 'MyString', @repository.code_of_conducts.first.path
  end
end
