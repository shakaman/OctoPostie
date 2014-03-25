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
        id: "listtestboard1"
        name: "Test"
        closed: false
        idBoard: "idboard1"
        pos: 49153
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

cards = [
  {
    id: "52ff9cb3bebadc681566de86"
    idShort: 3
    shortLink: "FrQu2NM1"
  }
  {
    id: "52ff9cc5d0940adc4da3d5bf"
    idShort: 4
    shortLink: "A3i4piPJ"
  }
  {
    id: "52ff9cfe429eaa9269512502"
    idShort: 5
    shortLink: "1AXodNbC"
  }
  {
    id: "52ff9d11733ec68415a81f52"
    idShort: 6
    shortLink: "oSQnhucK"
  }
  {
    id: "530d908413afd0762a2f688d"
    idShort: 8
    shortLink: "yHlHpWLp"
  }
  {
    id: "52ff9d1f1165d4e5607deb75"
    idShort: 7
    shortLink: "K0gOVOtM"
  }
  {
    id: "52ff8def48ecb2166b876e86"
    idShort: 2
    shortLink: "EHm8BHxh"
  }
  {
    id: "52ff8b7f73311bef603d64f5"
    idShort: 1
    shortLink: "eB8l1N7A"
  }
]

module.exports =
  boards: boards
  cards: cards
