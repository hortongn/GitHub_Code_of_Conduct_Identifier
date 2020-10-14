# IT Project

## Problem Statement

Open source software typically relies on communities of people who donate their time and expertise to enhance the software, report bugs, develop documentation, etc.  Most of this participation is online and potentially includes people from different cultures, ethnicities, ages, sexual orientations, and genders.  Like many other online communities, however, the actions of some participants in open source communities can make other participants feel unwelcome, unsafe, or attacked causing them to potentially withdraw from those projects.  Having a less diverse group of people working on an open source project may then increase the possibility of biases in the software.

To combat this problem, many open source projects have adopted codes of conduct that define community standards, signal a welcoming and inclusive project, and outline procedures for handling abuse.  However, many different types of codes of conduct exist and many different projects might adopt the same code of conduct.  It can also be difficult to locate the code of conduct for a project, if one exists at all.

## Research Questions

RQ1: What type of codes of conduct are used by popular open source projects?

RQ2: How do popular open source projects cite their codes of conduct?

RQ3: How reliably can codes of conduct be programatically identified?

## Method

Intro?

### Data Source (Particpants)

This study used data from GitHub.com.  GitHub is a collaborative software service that provides hosting for source code management and version control.  Because it facilitates collaborative development in a transparent environment, GitHub is a popular host for open source projects.  Hence, GitHub was a good source of data for this study.  There are several projects that have colleted GitHub data into datasets to faciliate research.  However, they are typically focused on transactional events (commits, comments, etc.) and only provide a snapshop of a certain point in time.  Given that some software repositories change very rapidly, existing datasets become outdated very quickly. We therefore chose to use GitHub's API for this study and directly query the serivce's live data.

GitHub's API provides an interface to most of the service's functions.  For this study in particular, we required the ability to search GitHub repositories for specific text in files or file names.  GitHub's Search API (https://docs.github.com/en/free-pro-team@latest/rest/reference/search) provided this functionality.  The Search API returns JSON results with a listing of files that match the query. 

API Limitations
* rate limit
* 1000 results per search
* queries must be <= 256 chars
* only the default branch is searched
* Only files smaller than 384 KB are searchable.

* number (N = ?)
* how I chose my set of repos
* screening?  How selected?  exclusions?
* basic demographics
* ingested by the app into a database
* db schema



### Apparatus (materials)
* the framework, gems, etc (why?
  * ruby on rails
  * rapid development
  * octokit gem
  * sidekiq
  * tests
* how the app works 
  * models
    * code of conducts
    * code of conduct types - why did I choose them?
      * fingerprints
    * repositories
    * repository sets
  * services
    * repository loader
    * github search
  * seeds
  * diagram?
* how I chose to find COCs
  * identified vs unidentified
  * by fingerprint
  * by text search
  * by file name
* the hosting
  * AWS


### Procedure
* starting the app/sidekiq
* Step by step
  * the workflow
    * create a set
    * run the service
    * view the COCs
    * view stats
* make sure someone else could do it
* how long it took
* when it was run
* explain how measurements were made and what calculations were performed
* and state which statistical tests were done to analyze the data.
* Does this actually test the hypothesis?


## Analysis

## Limitations and Implications

## Conclusions

## References
