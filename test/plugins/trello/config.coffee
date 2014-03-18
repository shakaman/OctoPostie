config =
  trello:
    api: 'http://api.trello.com/1'
    key: '123456789'
    token: '123456789'
    urls:
      lists: ":api/boards/:id?members=all&lists=all&key=:key&token=:token"
      cards: ":api/boards/:id/cards/?fields=idShort,shortLink&key=:key&token=:token"
      card: ":api/cards/:id/actions/comments?key=:key&token=:token"
  projects: [
    {
      name: 'project1'
      boardId: 'boardId1'
    }
    {
      name: 'project2'
      boardId: 'boardId2'
    }
  ]

module.exports = config
