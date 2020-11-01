require 'test_helper'

class RepositoryLoadersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository_loader = repository_loaders(:one)
  end

  test "should get new" do
    get new_repository_loader_url
    assert_response :success
  end

  test "should create repository_loader" do
    assert_difference('Repository.count') do
      post repository_loaders_url, params: { repository_loader: { repository_list: @repository_loader.repository_list } }
    end

    assert_redirected_to repository_set_url(RepositorySet.last)
  end

  test "should update repository_loader" do
    patch repository_loader_url(@repository_loader), params: { repository_loader: { repository_list: @repository_loader.repository_list } }
    assert_redirected_to repository_loader_url(@repository_loader)
  end

  test "should destroy repository_loader" do
    assert_difference('RepositoryLoader.count', -1) do
      delete repository_loader_url(@repository_loader)
    end

    assert_redirected_to repository_loaders_url
  end
end
