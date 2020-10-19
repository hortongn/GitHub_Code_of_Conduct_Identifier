# GitHub Code of Conduct Identifier

## Problem Statement

Open source software typically relies on communities of people who donate their time and expertise to enhance the software, report bugs, develop documentation, etc.  Most of this participation is online and potentially includes people from different cultures, ethnicities, ages, sexual orientations, and genders.  Like many other online communities, however, the actions of some participants in open source communities can make other participants feel unwelcome, unsafe, or attacked causing them to potentially withdraw from those projects.  Having a less diverse group of people working on an open source project may then increase the possibility of biases in the software.

To combat this problem, many open source projects have adopted codes of conduct that define community standards, signal a welcoming and inclusive project, and outline procedures for handling abuse.  However, many different types of codes of conduct exist and many different projects might adopt the same code of conduct.  It can also be difficult to locate the code of conduct for a project, if one exists at all.

(more?)

## Research Questions

RQ1: What type of codes of conduct are used by popular open source projects?

RQ2: How do popular open source projects cite their codes of conduct?

RQ3: How reliably can codes of conduct be programmatically identified?

## Methodology

### Data Source

The study used data from GitHub.com.  GitHub is a collaborative software service that provides hosting for source code management and version control.  Because it facilitates collaborative development in a transparent environment, GitHub is a popular host for open source projects.  Hence, GitHub was a good source of data for the study.  There are several projects that have collected GitHub data into datasets to facilitate research.  However, they are typically focused on transactional events (commits, comments, etc.) and only provide a snapshot of a certain point in time.  Given that some software repositories change very rapidly, existing datasets become outdated very quickly. We therefore chose to use GitHub's API for the study to directly query the service's live data.

GitHub's API provides an interface to most of the service's functions.  For this study in particular, we required the ability to search GitHub repositories for specific text in files or file names.  GitHub's Search API (https://docs.github.com/en/free-pro-team@latest/rest/reference/search) provided this functionality.  The Search API returns JSON results with a listing of files that match the query. For example, submitting the query "code of conduct" in:file repo:microsoft/test" will return all files in the microsoft/test repository that contain the text "code of conduct."  GitHub's API also provides the ability to search for files by filename.  

A sample size of 100 GitHub repositories was used for the study.  We created a list of the 100 most popular repositories by searching GitHub for repositories with the most stars.  Because the scope of the study is limited to open source projects, only software repositories with open source licenses were used.  A list of the repositories can be found at <>.

(used format login/name)

### Apparatus

To answer the research questions, I developed a software application that accepts a list of GitHub software repositories as input and searches those repositories for codes of conduct.  The application attempts to identify the types of codes of conduct used and displays links to them.

I chose to build the application using the Ruby on Rails framework.  Using the Model, View, Controller (MVC) architecture, Ruby on Rails allows for rapid software development and was therefore a good tool for a study under time constraints.  All application content is stored in a relational database.  The application also utilizes the Octokit toolkit (http://octokit.github.io/octokit.rb/) to facilitate using the GitHub API.  To prevent abuse of the API, GitHub limits the number of API calls that can be made in a given time period.  Fortunately, Octokit allows for authenticated API calls, which increases the call rate.  However, the application still hit some API limits even when using an authenticated API.  This required me to insert pauses into the application and causes the search feature to run artificially slowly.  TO alleviate this constraint I configured the API searches to run as background jobs.  Using the Sidekiq toolkit (https://sidekiq.org), the application can search code codes of conduct in the background without the user having to wait for the job to finish.

The application uses several different models:

* _Repository_: Stores the login and name of a single GitHub repository.  A _Repository_ object belongs to a single _RepositorySet_ object and has a one-to-many relationship with _CodeOfConduct_ objects.

* _RepositorySet_: A grouping of repositories.  A _RepositorySet_ object only stores the name of the set and has a one-to-many relationship with _Repository_ objects.

* _CodeOfConduct_: Stores the path of the code of conduct file in the GitHub repository as well as the URL to the file on GitHub.com.  A _CodeOfConduct_ object belongs to a single _Repository_ object and belongs to a single _CodeOfConductType_ object.

* _CodeOfConductType_: Defines a type of code of conduct.  Many codes of conduct are based on other popular codes of conduct.  A _CodeOfConductType_ object represents a single type of code of conduct and stores a name and a URL to where the type is defined.  It also stores a "fingerprint", which is a string of text that can be used to identify a code of conduct's type.  A _CodeOfConductType_ object has many _CodeOfConduct_ objects.

The application's GitHubService class performs the repository searching and identifies the codes of conduct.  The ID of a repository set is passed to the service.  As the service iterates through all repositories in the set, it makes GitHub Search API call for each repository.  The Search API attempts to find all files in the repository that match the fingerprint of one of the code of conduct types.  One of the code of conduct types has the simple fingerprint of "code of conduct" so that it will match any generic code of conduct in the repository.  For each found file, a new code of conduct object is created and associated with repository object. 

(search by file name)

The application's RepositoryLoader class takes a text-based list of repositories in _login/name_ format and for each repository creates a new repository object.  All new repository objects are also added to a new repository set object.  

hosting

### Application Preparation

Prerequisite: ruby 2.5 or newer

Clone and start the application:

1. Clone the application<br />`git clone https://github.com/hortongn/IT_Project.git`

1. Change to the application directory<br />`cd IT_Project`

1. Install Bundler<br />`gem install bundler`

1. Run Bundler<br />`bundle install`

1. Run the migrations<br />`bundle exec rails db:migrate`

1. Seed the database<br />`bundle exec rails db:seed`

1. Start the application and background workers
    * `redis-server`
    * `bundle exec sidekiq`
    * `bundle exec rails server`

1. In your web browser visit http://localhost:3000

### Procedure

The following procedure was used to generate the results for the study.

set up codes of conduct

1. Clicked the `REPOSITORY SETS` navigation link
1. On the Repository Sets page, clicked the `Create New Repository Set` button.
1. On the New Repository Set page
    * Entered the name "Open source sample set" for the new set
    * Pasted in a list of GitHub repositories in login/name format (the list of repositories can be found at ...)
    * Clicked the `Create Repository Set` button.  The application created a new "set" that includes all of the entered GitHub repositories.
1. On the Repository Set page, clicked the "Run this set" button. The application created a new background job to find codes of conduct for each GitHub repository in the set.  The job called two services:
    * search for text
    * search by file name
1. After XXX hours, reloaded the "Codes Of Conduct for Set Open source sample set" page.  XXX codes of conduct were listed on the page.  
1. View stats

## Limitations and Implications

API Limitations
* rate limit
* 1000 results per search
* queries must be <= 256 chars
* only the default branch is searched
* Only files smaller than 384 KB are searchable.

## Analysis

* explain how measurements were made and what calculations were performed
* and state which statistical tests were done to analyze the data.
* Does this actually test the hypothesis?

## Conclusions

## References