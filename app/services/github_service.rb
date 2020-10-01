class GithubService

  def search_repository(repository)
    CodeOfConductType.all.each do |code_of_conduct_type|
      @github = Octokit::Client.new(:netrc => true)
      results = @github.search_code "#{code_of_conduct_type.fingerprint_1} in:file repo:#{repository.login}/#{repository.name}"

      results.items.each do |item|
        CodeOfConduct.create(path: item.path, repository_id: repository.id, code_of_conduct_type_id: code_of_conduct_type.id)
      end
      sleep 20
    end
  end

  def get_codes_of_conduct(query, repository)
    search_repository(query, repository).each do |path|
      CodeOfConduct.create(path: path, repository_id: repository.id, code_of_conduct_type_id: identify_code_of_conduct_type)
    end
  end
end
