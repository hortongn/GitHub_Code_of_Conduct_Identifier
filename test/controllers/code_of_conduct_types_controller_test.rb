require 'test_helper'

class CodeOfConductTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @code_of_conduct_type = code_of_conduct_types(:one)
  end

  test "should get index" do
    get code_of_conduct_types_url
    assert_response :success
  end

  test "should get new" do
    get new_code_of_conduct_type_url
    assert_response :success
  end

  test "should create code_of_conduct_type" do
    assert_difference('CodeOfConductType.count') do
      post code_of_conduct_types_url, params: { code_of_conduct_type: { name: @code_of_conduct_type.name, url: @code_of_conduct_type.url } }
    end

    assert_redirected_to code_of_conduct_type_url(CodeOfConductType.last)
  end

  test "should show code_of_conduct_type" do
    get code_of_conduct_type_url(@code_of_conduct_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_code_of_conduct_type_url(@code_of_conduct_type)
    assert_response :success
  end

  test "should update code_of_conduct_type" do
    patch code_of_conduct_type_url(@code_of_conduct_type), params: { code_of_conduct_type: { name: @code_of_conduct_type.name, url: @code_of_conduct_type.url } }
    assert_redirected_to code_of_conduct_type_url(@code_of_conduct_type)
  end

  test "should destroy code_of_conduct_type" do
    assert_difference('CodeOfConductType.count', -1) do
      delete code_of_conduct_type_url(@code_of_conduct_type)
    end

    assert_redirected_to code_of_conduct_types_url
  end
end
