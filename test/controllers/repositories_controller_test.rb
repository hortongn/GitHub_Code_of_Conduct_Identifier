require 'test_helper'

class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository_set = RepositorySet.create(name: "test")
    @repository = repositories(:one)
  end

  test "should create repository" do
    assert_difference('Repository.count') do
      post repositories_url, params: { repository: { description: @repository.description, login: @repository.login, name: @repository.name, stars: @repository.stars, url: @repository.url, repository_set_id: @repository_set.id } }
    end

    assert_redirected_to repository_url(Repository.last)
  end

  test "should destroy repository" do
    assert_difference('Repository.count', -1) do
      delete repository_url(@repository)
    end

    assert_redirected_to repositories_url
  end
end
