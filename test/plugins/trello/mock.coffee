boards = [
  {
    id: "idboard1"
    name: "Board1"
    desc: ""
    descData: null
    closed: false
    idOrganization: "oarganisation1"
    pinned: true
    url: "https://trello.com/b/idboard1/board1"
    shortUrl: "https://trello.com/b/idboard1"
    prefs:
      permissionLevel: "org"
      voting: "disabled"
      comments: "members"
      invitations: "members"
      selfJoin: false
      cardCovers: true
      cardAging: "regular"
      background: "purple"
      backgroundColor: "#6D5798"
      backgroundImage: null
      backgroundImageScaled: null
      backgroundTile: false
      backgroundBrightness: "unknown"
      canBePublic: true
      canBeOrg: true
      canBePrivate: true
      canInvite: true
    labelNames:
      red: "label 1"
      orange: "label 2"
      yellow: "label 3"
      green: "label 4"
      blue: "label 5"
      purple: "label 6"
    lists: [
      {
        id: "listtodoboard1"
        name: "To Do"
        closed: false
        idBoard: "idboard1"
        pos: 16384
        subscribed: false
      }
      {
        id: "listdoingboard1"
        name: "Doing"
        closed: false
        idBoard: "idboard1"
        pos: 32768
        subscribed: false
      }
      {
        id: "listdoneboard1"
        name: "Done"
        closed: false
        idBoard: "idboard1"
        pos: 49152
        subscribed: false
      }
    ]
    members: [
      {
        id: "user1"
        avatarHash: "hashuser1"
        initials: "A"
        fullName: "User 1"
        username: "user_1"
        confirmed: true
      }
      {
        id: "user2"
        avatarHash: "hashuser2"
        initials: "B"
        fullName: "User 2"
        username: "user_2"
        confirmed: true
      }
    ]
  }
  {
    id: "idboard2"
    name: "Board2"
    desc: ""
    descData: null
    closed: false
    idOrganization: "oarganisation1"
    pinned: true
    url: "https://trello.com/b/idboard2/board2"
    shortUrl: "https://trello.com/b/idboard2"
    prefs:
      permissionLevel: "org"
      voting: "disabled"
      comments: "members"
      invitations: "members"
      selfJoin: false
      cardCovers: true
      cardAging: "regular"
      background: "purple"
      backgroundColor: "#6D5798"
      backgroundImage: null
      backgroundImageScaled: null
      backgroundTile: false
      backgroundBrightness: "unknown"
      canBePublic: true
      canBeOrg: true
      canBePrivate: true
      canInvite: true
    labelNames:
      red: "label 1"
      orange: "label 2"
      yellow: "label 3"
      green: "label 4"
      blue: "label 5"
      purple: "label 6"
    lists: [
      {
        id: "listtodoboard2"
        name: "To Do"
        closed: false
        idBoard: "idboard2"
        pos: 16384
        subscribed: false
      }
      {
        id: "listdoingboard2"
        name: "Doing"
        closed: false
        idBoard: "idboard2"
        pos: 32768
        subscribed: false
      }
      {
        id: "listdoneboard2"
        name: "Done"
        closed: false
        idBoard: "idboard2"
        pos: 49152
        subscribed: false
      }
    ]
    members: [
      {
        id: "user1"
        avatarHash: "hashuser1"
        initials: "A"
        fullName: "User 1"
        username: "user_1"
        confirmed: true
      }
      {
        id: "user2"
        avatarHash: "hashuser2"
        initials: "B"
        fullName: "User 2"
        username: "user_2"
        confirmed: true
      }
    ]
  }
]

module.exports = boards
