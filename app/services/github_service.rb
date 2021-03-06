class GithubService

  def iterate_repositories(repository_set_id)
    repository_set = RepositorySet.find(repository_set_id)
    repository_set.repositories.each do |repo|
      GithubService.new.search_repository(repo)
      GithubService.new.search_by_filename(repo)
    end
    repository_set.running = false
    repository_set.save
  end

  def search_repository(repository)
    CodeOfConductType.all.each do |code_of_conduct_type|
      @github = Octokit::Client.new(:netrc => true)
      results = @github.search_code "\"#{code_of_conduct_type.fingerprint_1}\" in:file repo:#{repository.login}/#{repository.name}"

      results.items.each do |item|
        unless file_is_previously_found?(item, repository) || file_is_too_deep?(item.path) || file_has_invalid_extension?(item.path)
          CodeOfConduct.create(path: item.path, url: item.html_url, repository_id: repository.id, code_of_conduct_type_id: code_of_conduct_type.id)
        end
      end
      sleep 60
    end
  end

  def search_by_filename(repository)
    @github = Octokit::Client.new(:netrc => true)
    results = @github.search_code "filename:*code*conduct* repo:#{repository.login}/#{repository.name}"

    results.items.each do |item|
      unless file_is_previously_found?(item, repository) || file_is_too_deep?(item.path) || file_has_invalid_extension?(item.path)
        CodeOfConduct.create(path: item.path, url: item.html_url, repository_id: repository.id, code_of_conduct_type_id: CodeOfConductType.find_by_name("Unidentified").id)
      end
    end
    sleep 60
  end

  def file_is_previously_found?(item, repository)
    return true unless CodeOfConduct.where(path: item.path, repository_id: repository.id).blank?
  end

  def file_is_too_deep?(path)
    return true if path =~ /\/.*\//
  end

  def file_has_invalid_extension?(path)
    return true unless path =~ /.*.md/ || path =~ /.*.txt/ || path =~ /.*.rst/ || path =~ /.*.html/
  end

end
