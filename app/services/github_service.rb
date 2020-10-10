class GithubService

  def iterate_repositories(repository_set_id)
    repository_set = RepositorySet.find(repository_set_id)
    repository_set.repositories.each do |repo|
      GithubService.new.search_repository(repo)
    end
  end

  def search_repository(repository)
    CodeOfConductType.all.each do |code_of_conduct_type|
      @github = Octokit::Client.new(:netrc => true)
      results = @github.search_code "\"#{code_of_conduct_type.fingerprint_1}\" in:file repo:#{repository.login}/#{repository.name}"

      results.items.each do |item|
        unless file_is_previously_found?(item, repository)
          CodeOfConduct.create(path: item.path, url: item.html_url, repository_id: repository.id, code_of_conduct_type_id: code_of_conduct_type.id)
        end
      end
      sleep 60
    end
  end

  def file_is_previously_found?(item, repository)
    return true unless CodeOfConduct.where(path: item.path, repository_id: repository.id).blank?
  end

#  def get_codes_of_conduct(query, repository)
#    search_repository(query, repository).each do |path|
#      CodeOfConduct.create(path: path, repository_id: repository.id, code_of_conduct_type_id: identify_code_of_conduct_type)
#    end
#  end
end
