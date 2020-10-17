class FindCodesOfConductJob < ApplicationJob
  queue_as :default

  def perform(repository_set_id)
    GithubService.new.iterate_repositories(repository_set_id)
  end
end
