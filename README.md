# GitHub Code of Conduct Identifier

## Problem Statement

Open source software relies on communities of people who donate their time and expertise to enhance the software, report bugs, develop documentation, etc.  Most of this participation is online and potentially includes people from different cultures, ethnicities, ages, sexual orientations, and genders.  Like many other online communities, however, the actions of some participants in open source communities can make other participants feel unwelcome, unsafe, or attacked causing them to potentially withdraw from those projects.  Having a less diverse group of people working on an open source project may then increase the possibility of biases in the software.

To combat this problem, many open source projects have adopted a "code of conduct" that defines community standards, signals a welcoming and inclusive project, and outlines procedures for handling abuse.  However, many different types of codes of conduct exist and many different projects might adopt the same code of conduct type.  It can also be difficult to locate the code of conduct for a project, if one exists at all.

## Research Questions

RQ1: How do popular open source projects cite their codes of conduct?

RQ2: What types of codes of conduct are used by popular open source projects?

## Methodology

### Data Source

The study used data from GitHub.com.  GitHub is a collaborative software service that provides hosting for source code management and version control.  Because it facilitates collaborative development in a transparent environment, GitHub is a popular host for open source projects.  Hence, GitHub was a logical source of data for the study.  There are several other projects that have collected GitHub data into datasets to facilitate research.  However, they are typically focused on transactional events (commits, comments, etc.) and only provide a snapshot of a certain point in time.  Given that some software repositories change very rapidly, existing datasets become outdated very quickly. I therefore chose to use GitHub's API for the study to directly query the service's live data.

GitHub's API provides an interface to most of the service's functions.  For this study in particular, I required the ability to search GitHub repositories for specific text in files or file names.  GitHub's Search API (https://docs.github.com/en/free-pro-team@latest/rest/reference/search) provided this functionality.  The Search API returns JSON results with a listing of files that match the query. For example, submitting the query _"code of conduct" in:file repo:microsoft/test_ will return all files in the microsoft/test repository that contain the text "code of conduct."  GitHub's API also provides the ability to search for files by filename.  

A sample size of 50 GitHub repositories was used for the study.  The sample set was derived from the top 50 repositories on the list of _GitHub’s Top 100 Most Valuable Repositories Out of 96 Million_.  Because the scope of the study is limited to open source projects, only software repositories with open source licenses were used.  A list of the repositories (using the format "login/name") can be found at https://raw.githubusercontent.com/hortongn/GitHub_Code_of_Conduct_Identifier/main/public/hackernoon_repos.txt.

### Apparatus

To answer the research questions, I developed a software application that accepts a list of GitHub software repositories as input and searches those repositories for code of conduct files.  The application also attempts to identify the types of codes of conduct used and displays links to them.

I chose to build the application using the Ruby on Rails framework.  Using the Model, View, Controller (MVC) architecture, Ruby on Rails allows for rapid software development and was therefore a good tool for a study under the time constraints.  All application content is stored in a relational database.  The application also utilizes the Octokit toolkit (http://octokit.github.io/octokit.rb/) to facilitate using the GitHub API.  To prevent abuse of the API, GitHub limits the number of API calls that can be made in a given time period.  Fortunately, Octokit allows for authenticated API calls, which increases the call rate.  However, the application still hit some API limits even when using an authenticated API.  This required me to insert pauses into the application and caused the search feature to run artificially slowly.  After each API call, there is a 60 second pause.  To alleviate this constraint I configured the API searches to run as background jobs.  Using the Sidekiq toolkit (https://sidekiq.org), the application can search codes of conduct in the background without the user having to wait for the job to finish.

The application uses several different models:

* _Repository_: Stores the login and name of a single GitHub repository.  A _Repository_ object belongs to a single _RepositorySet_ object and has a one-to-many relationship with _CodeOfConduct_ objects.

* _RepositorySet_: A grouping of repositories.  A _RepositorySet_ object only stores the name of the set and has a one-to-many relationship with _Repository_ objects.

* _CodeOfConduct_: Stores the path of the code of conduct file in the GitHub repository as well as the URL to the file on GitHub.com.  A _CodeOfConduct_ object belongs to a single _Repository_ object and belongs to a single _CodeOfConductType_ object.

* _CodeOfConductType_: Defines a type of code of conduct.  Many codes of conduct are based on other popular codes of conduct.  A _CodeOfConductType_ object represents a single type of code of conduct and stores a name and a URL to where the type is defined.  The application is currently configured to find six different types of codes of conduct.  The six most popular types found by (Tourani et al., 2017) can be viewed at https://github.com/hortongn/GitHub_Code_of_Conduct_Identifier/blob/main/db/seeds.rb.  The model also stores a "fingerprint", which is a string of text that can be used to identify a code of conduct's type.  I attempted to find a unique sentence from each type to use as a reliable fingerprint.  A _CodeOfConductType_ object has many _CodeOfConduct_ objects.

The application's GitHubService class performs the repository searching and identifies the codes of conduct.  The ID of a repository set is passed to the service.  As the service iterates through all repositories in the set, it makes two GitHub Search API calls per repository:
* Text search: The Search API attempts to find all files in the repository that match the fingerprint of one of the code of conduct types.  One of the code of conduct types has the simple fingerprint of "code of conduct" so that it will match any generic code of conduct in the repository.
* File name search: The Search API attempts to find all files in the repository with the file name pattern `*code*conduct*`.  This matches all files with the word "code" followed by the word "conduct" in the file name.    
For each found file, a new code of conduct object is created and associated with a repository object.

The application's RepositoryLoader class takes a text-based list of repositories in _login/name_ format and for each repository creates a new repository object.  All new repository objects are also added to a new repository set object.  

### Application Preparation

Prerequisite: ruby 2.5 or newer

Clone and start the application:
1. Clone the application from GitHub.com: `https://github.com/hortongn/GitHub_Code_of_Conduct_Identifier.git`
1. Change to the application directory: `cd GitHub_Code_of_Conduct_Identifier`
1. Install Bundler: `gem install bundler`
1. Run Bundler: `bundle install`
1. Run the migrations: `bundle exec rails db:migrate`
1. Seed the database: `bundle exec rails db:seed`
1. To use an authenticated GitHub API, add your GitHub credentials to ~/.netrc:
    * `machine api.github.com`
    * `  login your-username`
    * `  password your-password`
1. Start the application and background workers on three separate shell prompts:
    * `redis-server`
    * `bundle exec sidekiq`
    * `bundle exec rails server`
1. In your web browser visit http://localhost:3000

### Procedure

The following procedure was used to generate the results for the study.  The same procedure can be repeated to replicate the results.

1. Clicked the `REPOSITORY SETS` navigation link
1. On the Repository Sets page, clicked the `Create New Repository Set` button.
1. On the New Repository Set page
    * Entered the name "Open source sample set" for the new set
    * Pasted in a list of GitHub repositories in login/name format (https://raw.githubusercontent.com/hortongn/GitHub_Code_of_Conduct_Identifier/main/public/hackernoon_repos.txt)
    * Clicked the `Create Repository Set` button.  The application created a new "set" that includes all of the entered GitHub repositories.
1. On the Repository Set page, clicked the "Run this set" button. The application created a new background job to find codes of conduct for each GitHub repository in the set.  The job called two services:
    * search for text
    * search by file name
1. After approximately 200 minutes, reloaded the "Codes Of Conduct for Set Open source sample set" page to view the results.

After running the set of 50 hackernoon repositories, the application returned a large number of results that contained many false positives.  After manually inspecting the results, I observed several trends in the false positives:
* A single file sometimes appeared twice in the results because it was identified by both the text search algorithm and the filename search algorithm.  I resolved this by adding a filter that ignored files if they had already been found.
* Actual code of conduct files are always found in the root of the repository or in a single directory below the root.  Many false positive files that included the phrase "code of conduct" were showing up two, three, or more levels deep.  I resolved this by adding a filter that ignored files more than one directory deep in the repository.
* Actual code of conduct files almost always have the file name extension .md, .txt, .rst, or .html.  Many false positive files with other file name extensions were showing up in the results.  I resolved this by adding a filter that ignored files without the above file name extensions.
* I made slight adjustments to the fingerprints for the code of conduct types to better match real codes of conduct.

I also observed that some files in the results simply had links to the code of conduct instead of actually containing the code of conduct in the file.  However, I chose to keep the behavior since it did help identify where the legitimate code of conduct resided.

After making the adjustments above, I ran the entire procedure again and generated the new results.

## Analysis

Of the 50 GitHub repositories evaluated in the study, 24 of them had at least one file identified by the application as a potential code of conduct.  Some repositories had multiple files identified for a total of 47 files across the 24 repositories.  For each file, the application listed the GitHub repository, the path to the file, and the type of code of conduct (if identified).  See the sample output below.

![Code of conducts example](https://github.com/hortongn/GitHub_Code_of_Conduct_Identifier/raw/main/public/example.png)

To answer the first research question, _How do popular open source projects cite their codes of conduct?_, I grouped the 47 files by file name to determine the frequency of their file paths.

| Path                                           | Frequency |
| ---------------------------------------------- | --------- |
| README                                         |        13 |
| CODE_OF_CONDUCT.md                             |        12 |
| CONTRIBUTING.md                                |         7 |
| .github/CODE_OF_CONDUCT.md                     |         5 |
| CODE-OF-CONDUCT.md                             |         3 |
| .github/CONTRIBUTING.md                        |         1 |
| code-of-conduct.md                             |         1 |
| contributing/creating-a-welcoming-community.md |         1 |
| contributing/DEVELOPING.md                     |         1 |
| doc/help.html                                  |         1 |
| docs/moderator-handbook.md                     |         1 |
| onboarding.md                                  |         1 |

The most popular file path was _README_ with either a _.md_ or _.rst_ extension in the root level of the repository.  README files on Github often contain information useful for people new to the project.  So it makes sense that a code of conduct would be referenced there.  Closely following in popularity was _CODE_OF_CONDUCT.md_ in the root level of the repository.  It's common for informational files on GitHub to have all upper-case file names to distinguish them from the code base.  The third most popular file path was _CONTRIBUTING.md_.  Again, this makes sense because the CONTRIBUTING file generally has information useful to people who want to contribute to the project.  Five of the file paths were _.github/CODE_OF_CONDUCT.md_.  This is the standard path used if one requests GitHub to automatically generate a code of conduct file.  It's a bit surprising that more repositories don't use this GitHub standard.  Finally, a few of the files have the path _CODE-OF-CONDUCT.md_, which is a variation of _CODE_OF_CONDUCT.md_.

The rest of the file paths only occurred once each in the sample set.  These locations would not be as obvious as the more popular locations above.

Most of the files identified by the application, however, didn't actually contain codes of conduct.  Out of the 47 files identified, 31 of them simply linked to external codes of conduct on different websites.  Five of them linked to codes of conduct located elsewhere in the same repository.  Only 8 of the identified files actually contained the full code of conduct for their respective repositories.

The study attempted to answer the second research question, _What types of codes of conduct are used by popular open source projects?_, by looking for strings of text ("fingerprints") in the files.  If a fingerprint matched a file, it was assumed that the file contained a certain type of code of conduct.  

The application successfully identified the type of code of conduct for only five repositories.  All five were identified as being based on the Contributor Covenant code of conduct (https://www.contributor-covenant.org).  The application was unable to identify more types because, as stated above, only 8 of the identified files actually contained the full code of conduct text.  In most cases the GitHub repositories simply linked to codes of conduct in other locations.  Hence, the application was not able to search the text of the code of conduct to identify it.  

Given that all of the identified types were Contributor Covenant, it's likely that Contributor Covenant is the most popular code of conduct type used on Github.

## Limitations and Implications

The study had a few limiting factors:

* The GitHub API imposed a limit on the rate of API calls.  The application had to pause for up to 60 seconds between each call.  For the sample set of 50 repositories in the study, the runtime to find the codes of conduct was approximately 400 minutes.  A large sample size of repositories (N = 100) would have been preferred, but it would have taken over 13 hours to run.

* The GitHub API imposed a limit of 256 characters on searches.  The fingerprints for code of conduct types had to be shorter than ideal length so they could fit within the API limits.  Longer fingerprints would allow for more certainly in matches.

* The timeline for this study had to remain in line with the timeline of the class.  More robust methods could have been implemented in the application if there were more time for software development.

## Conclusions

Only about half of the Github repositories evaluated in this study had codes of conduct.  Given that these are collaborative, open source projects, participation from diverse groups is encouraged.  However, without a code of conduct a project's community will have a more difficult time upholding values and punishing abusers.  This can lead to less diverse communities and bias in software.

Of the repositories that referenced a code of conduct, most used a file naming convention that was logical and would make the code of conduct fairly easy to locate by members of the project's development community.  However, some repositories buried their code of conduct in file paths that made them difficult to find without doing a keyword search.  A code of conduct should be one of the first things someone sees when they encounter a new collaborative development project.  People will be more likely to participate in a community if they can easily tell if the community will protect its members.

Because most of the repositories linked to external codes of conduct instead of including them in the repository, the study wasn't able to determine many code of conduct types.  Of those that were identified, all were based on the Contributor Covenant code of conduct.  Therefore, the Contributor Covenant can be considered a strong starting point for a project looking to implement a new code of conduct.

## References

Gaviar, A. (2019). GitHub’s Top 100 Most Valuable Repositories Out of 96 Million. Retrieved from https://hackernoon.com/githubs-top-100-most-valuable-repositories-out-of-96-million-bb48caa9eb0b.

Robson, N. (2018). Diversity and decorum in open source communities. _Proceedings of the 2018 26th ACM Joint Meeting on European Software Engineering Conference and Symposium on the Foundations of Software Engineering - ESEC/FSE_ 2018, 986–987. https://doi.org/10.1145/3236024.3275441

Sholler, D., Steinmacher, I., Ford, D., Averick, M., Hoye, M., & Wilson, G. (2019). Ten simple rules for helping newcomers become contributors to open projects. _PLOS Computational Biology_, 15(9), e1007296. https://doi.org/10.1371/journal.pcbi.1007296

Tourani, P., Adams, B., & Serebrenik, A. (2017). Code of conduct in open source projects. *2017 IEEE 24th International Conference on Software Analysis, Evolution and Reengineering (SANER)*, 24–33. https://doi.org/10.1109/SANER.2017.7884606
