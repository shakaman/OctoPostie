payload =
  ref: "refs/heads/master"
  after: "2c2fc2453a785328833d573f838881dd599cdc5c"
  before: "125a1d4aafb276626262425e8c22ff7bcbc6fd48"
  created: false
  deleted: false
  forced: false
  compare: "https://github.com/shakaman/OctoPostie/compare/125a1d4aafb2...2c2fc2453a78"
  commits: [
    {
      id: "bb55b42a83ab68aa90f2f631352b2b2ce3ea6986"
      distinct: true
      message: "Add specs on trello plugin"
      timestamp: "2014-03-18T21:28:58+01:00"
      url: "https://github.com/shakaman/OctoPostie/commit/bb55b42a83ab68aa90f2f631352b2b2ce3ea6986"
      author:
        name: "shakaman"
        email: "pseudo@email.com"
        username: "shakaman"

      committer:
        name: "shakaman"
        email: "pseudo@email.com"
        username: "shakaman"

      added: ["test/plugins/trello/mock.coffee"]
      removed: []
      modified: [
        "package.json"
        "src/plugins/trello/plugin.coffee"
        "test/plugins/trello/config.coffee"
        "test/plugins/trello/plugin_spec.coffee"
      ]
    }
    {
      id: "2c2fc2453a785328833d573f838881dd599cdc5c"
      distinct: true
      message: "Fix #2 : Switch name in gruntfile"
      timestamp: "2014-03-18T21:29:16+01:00"
      url: "https://github.com/shakaman/OctoPostie/commit/2c2fc2453a785328833d573f838881dd599cdc5c"
      author:
        name: "shakaman"
        email: "pseudo@email.com"
        username: "shakaman"

      committer:
        name: "shakaman"
        email: "pseudo@email.com"
        username: "shakaman"

      added: []
      removed: []
      modified: ["Gruntfile.coffee"]
    }
  ]
  head_commit:
    id: "2c2fc2453a785328833d573f838881dd599cdc5c"
    distinct: true
    message: "See #2 : Switch name in gruntfile"
    timestamp: "2014-03-18T21:29:16+01:00"
    url: "https://github.com/shakaman/OctoPostie/commit/2c2fc2453a785328833d573f838881dd599cdc5c"
    author:
      name: "shakaman"
      email: "pseudo@email.com"
      username: "shakaman"

    committer:
      name: "shakaman"
      email: "pseudo@email.com"
      username: "shakaman"

    added: []
    removed: []
    modified: ["Gruntfile.coffee"]

  repository:
    id: 16844389
    name: "project1"
    url: "https://github.com/shakaman/OctoPostie"
    description: "Bind github's commits with various services"
    homepage: ""
    watchers: 3
    stargazers: 3
    forks: 0
    fork: false
    size: 224
    owner:
      name: "shakaman"
      email: "pseudo@email.com"

    private: false
    open_issues: 0
    has_issues: true
    has_downloads: true
    has_wiki: true
    language: "CoffeeScript"
    created_at: 1392399223
    pushed_at: 1395174580
    master_branch: "master"

  pusher:
    name: "shakaman"
    email: "pseudo@email.com"

module.exports = payload
