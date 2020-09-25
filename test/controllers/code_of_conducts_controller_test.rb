require 'test_helper'

class CodeOfConductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @code_of_conduct = code_of_conducts(:one)
  end

  test "should get index" do
    get code_of_conducts_url
    assert_response :success
  end

  test "should get new" do
    get new_code_of_conduct_url
    assert_response :success
  end

  test "should create code_of_conduct" do
    assert_difference('CodeOfConduct.count') do
      post code_of_conducts_url, params: { code_of_conduct: { path: @code_of_conduct.path, repository_id: @code_of_conduct.repository_id, sample_text: @code_of_conduct.sample_text } }
    end

    assert_redirected_to code_of_conduct_url(CodeOfConduct.last)
  end

  test "should show code_of_conduct" do
    get code_of_conduct_url(@code_of_conduct)
    assert_response :success
  end

  test "should get edit" do
    get edit_code_of_conduct_url(@code_of_conduct)
    assert_response :success
  end

  test "should update code_of_conduct" do
    patch code_of_conduct_url(@code_of_conduct), params: { code_of_conduct: { path: @code_of_conduct.path, repository_id: @code_of_conduct.repository_id, sample_text: @code_of_conduct.sample_text } }
    assert_redirected_to code_of_conduct_url(@code_of_conduct)
  end

  test "should destroy code_of_conduct" do
    assert_difference('CodeOfConduct.count', -1) do
      delete code_of_conduct_url(@code_of_conduct)
    end

    assert_redirected_to code_of_conducts_url
  end
end
