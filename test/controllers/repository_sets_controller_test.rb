require 'test_helper'

class RepositorySetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository_set = repository_sets(:one)
  end

  test "should get index" do
    get repository_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_repository_set_url
    assert_response :success
  end

  test "should create repository_set" do
    assert_difference('RepositorySet.count') do
      post repository_sets_url, params: { repository_set: { name: @repository_set.name } }
    end

    assert_redirected_to repository_set_url(RepositorySet.last)
  end

  test "should show repository_set" do
    get repository_set_url(@repository_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_repository_set_url(@repository_set)
    assert_response :success
  end

  test "should update repository_set" do
    patch repository_set_url(@repository_set), params: { repository_set: { name: @repository_set.name } }
    assert_redirected_to repository_set_url(@repository_set)
  end

  test "should destroy repository_set" do
    assert_difference('RepositorySet.count', -1) do
      delete repository_set_url(@repository_set)
    end

    assert_redirected_to repository_sets_url
  end
end
