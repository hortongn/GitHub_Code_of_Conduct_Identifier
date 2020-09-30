class GithubService

  def search_repository(query, repository)
    @github = Octokit::Client.new
    results = @github.search_code "#{query} in:file repo:#{repository.login}/#{repository.name}"

    code_of_conduct_paths = []

    results.items.each do |item|
      code_of_conduct_paths << item.path
    end

    return code_of_conduct_paths
  end

  def get_codes_of_conduct(query, repository)
    search_repository(query, repository).each do |path|
      CodeOfConduct.create(path: path, repository_id: repository.id, code_of_conduct_type_id: identify_code_of_conduct_type)
    end
  end

  def identify_code_of_conduct_type
    return 2
  end
end
