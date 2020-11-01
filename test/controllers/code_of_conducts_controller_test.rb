require 'test_helper'

class CodeOfConductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @code_of_conduct = code_of_conducts(:one)
  end

  test "should create code_of_conduct" do
    assert_difference('CodeOfConduct.count') do
      post code_of_conducts_url, params: { code_of_conduct: { path: @code_of_conduct.path, code_of_conduct_type_id: @code_of_conduct.code_of_conduct_type_id, repository_id: @code_of_conduct.repository_id } }
    end

    assert_redirected_to code_of_conduct_url(CodeOfConduct.last)
  end

  test "should update code_of_conduct" do
    patch code_of_conduct_url(@code_of_conduct), params: { code_of_conduct: { path: @code_of_conduct.path, code_of_conduct_type_id: @code_of_conduct.code_of_conduct_type_id, repository_id: @code_of_conduct.repository_id } }
    assert_redirected_to code_of_conduct_url(@code_of_conduct)
  end

  test "should destroy code_of_conduct" do
    assert_difference('CodeOfConduct.count', -1) do
      delete code_of_conduct_url(@code_of_conduct)
    end

    assert_redirected_to code_of_conducts_url
  end
end
