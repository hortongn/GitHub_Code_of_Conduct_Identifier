CodeOfConductType.all.destroy_all
CodeOfConductType.create(id: 1, name: 'Contributor Covenant', url: 'https://www.contributor-covenant.org/version/2/0/code_of_conduct/code_of_conduct.txt', fingerprint_1: 'adapted from the Contributor Covenant')
CodeOfConductType.create(id: 2, name: 'Django', url: 'https://www.djangoproject.com/conduct/', fingerprint_1: 'Be careful in the words that you choose')
CodeOfConductType.create(id: 3, name: 'Geek Feminism', url: 'https://geekfeminismdotorg.wordpress.com/about/code-of-conduct/', fingerprint_1: 'We do not tolerate harassment of participants in any form')
CodeOfConductType.create(id: 4, name: 'Open Code of Conduct', url: 'https://github.com/todogroup/opencodeofconduct', fingerprint_1: 'Our goal is to make explicit what we expect from participants in this community')
CodeOfConductType.create(id: 5, name: 'Python', url: 'https://www.python.org/psf/conduct/', fingerprint_1: 'Members of the community are considerate of their peers')
CodeOfConductType.create(id: 6, name: 'Ubuntu', url: 'https://ubuntu.com/community/code-of-conduct', fingerprint_1: 'Disagreement is no excuse for poor manners')
CodeOfConductType.create(id: 7, name: 'Unidentified', url: nil, fingerprint_1: 'code of conduct')

Repository.all.destroy_all
Repository.create(id: 1, login: 'vuejs', name: 'vue')
Repository.create(id: 2, login: 'facebook', name: 'react')
Repository.create(id: 3, login: 'tensorflow', name: 'tensorflow')
Repository.create(id: 4, login: 'twbs', name: 'bootstrap')
Repository.create(id: 5, login: 'sindresorhus', name: 'awesome')
Repository.create(id: 6, login: 'kamranahmedse', name: 'developer-roadmap')
Repository.create(id: 7, login: 'ohmyzsh', name: 'ohmyzsh')
Repository.create(id: 8, login: 'microsoft', name: 'vscode')
Repository.create(id: 9, login: 'flutter', name: 'flutter')
Repository.create(id: 10, login: 'torvalds', name: 'linux')
Repository.create(id: 11, login: 'facebook', name: 'react-native')
Repository.create(id: 12, login: 'electron', name: 'electron')
Repository.create(id: 13, login: 'axios', name: 'axios')
Repository.create(id: 14, login: 'golang', name: 'go')
Repository.create(id: 15, login: 'nodejs', name: 'node')
Repository.create(id: 16, login: 'ytdl-org', name: 'youtube-dl')
Repository.create(id: 17, login: 'kubernetes', name: 'kubernetes')
Repository.create(id: 18, login: 'microsoft', name: 'terminal')
Repository.create(id: 19, login: 'angular', name: 'angular')
Repository.create(id: 20, login: 'FortAwesome', name: 'Font-Awesome')
Repository.create(id: 21, login: 'python', name: 'cpython')
