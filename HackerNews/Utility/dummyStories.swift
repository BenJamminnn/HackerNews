//
//  dummyStories.swift
//  HackerNews
//
//  Created by Ben Gabay on 2/28/23.
//

import Foundation


let story = Story(by: "Ben",
                  id: 0,
                  score: 100,
                  time: 1677723071,
                  title: "Bens cool article",
                  type: .story,
                  url: "http://ben.com/beniscool",
                  descendants: 0,
                  kids: nil,
                  text: "some Text")
let story1 = Story(by: "Here's a really long username",
                   id: 0,
                   score: 90,
                   time: 1677733422,
                   title: "Here's a long article name, how will you format this one eh?",
                   type: .story,
                   url: "http://ben.com/beniscool",
                   descendants: 0,
                   kids: nil,
                   text: "some Text")
let story2 = Story(by: "Hello, it's me",
                   id: 0,
                   score: 112,
                   time: 1677750676,
                   title: "Bens super awesome marvelous cool article",
                   type: .story,
                   url: "http://google.com",
                   descendants: 0,
                   kids: nil,
                   text: "I'm going to get a job")
let story3 = Story(by: "Xx_d[-_-]b_xX",
                   id: 0,
                   score: 69,
                   time: 1677766826,
                   title: "Just an example",
                   type: .story,
                   url: "http://yahoo.com",
                   descendants: 0,
                   kids: nil,
                   text: "some Text")
let story4 = Story(by: "Joe Shmoe",
                   id: 0,
                   score: 231,
                   time: 1677609396,
                   title: "The internet has just been invented!",
                   type: .story,
                   url: "http://bing.com",
                   descendants: 0,
                   kids: nil,
                   text: "The machines are taking over")
let story5 = Story(by: "ARandomUser1113",
                   id: 0,
                   score: 34,
                   time: 1677677621,
                   title: "You should all comment on this",
                   type: .story,
                   url: "http://chewy.com",
                   descendants: 0,
                   kids: nil,
                   text: "some Text")
let story6 = Story(by: "IlovedogsLOL",
                   id: 0,
                   score: 99,
                   time: 1677603974,
                   title: "Birds are not real",
                   type: .story,
                   url: "http://reddit.com",
                   descendants: 0,
                   kids: nil,
                   text: "I repeat, birds ARE NOT REAL")
let story7 = Story(by: "TomFromMyspace",
                   id: 0,
                   score: 100,
                   time: 1677617962,
                   title: "I love skateboarding and you should too",
                   type: .story,
                   url: "http://myspace.com",
                   descendants: 0,
                   kids: nil,
                   text: "some Text")
let story8 = Story(by: "Rick Sanchez",
                   id: 0,
                   score: 100,
                   time: 1677766173,
                   title: "Rick Sanchez has figured out time travel",
                   type: .story,
                   url: "http://rickandmorty.com",
                   descendants: 0,
                   kids: nil,
                   text: "some Text")
let story9 = Story(by: "JohnnyStorm",
                   id: 0,
                   score: 100,
                   time: 1677616198,
                   title: "Johnny Storm was denied a loan today",
                   type: .story,
                   url: "http://marvel.com",
                   descendants: 0,
                   kids: nil,
                   text: "some Text")
let dummyStories = [story, story1, story2, story3, story4, story5, story6, story7, story8, story9]

let comment1 = Comment(by: "Example User",
                       id: 35016553,
                       kids: nil,
                       parent: 35015624,
                       text: "Hello this is just an example",
                       time: 1677887295,
                       type: .comment,
                       deleted: false
                       )
let comment2 = Comment(by: "Example User",
                       id: 35016553,
                       kids: nil,
                       parent: 35015624,
                       text: "Hello this is just an example",
                       time: 1677887295,
                       type: .comment,
                       deleted: false
                       )
let comment3 = Comment(by: "Example User",
                       id: 35016553,
                       kids: nil,
                       parent: 35015624,
                       text: "Hello this is just an example",
                       time: 1677887295,
                       type: .comment,
                       deleted: false
                       )
let comment4 = Comment(by: "Example User",
                       id: 35016553,
                       kids: nil,
                       parent: 35015624,
                       text: "Hello this is just an example",
                       time: 1677887295,
                       type: .comment,
                       deleted: false
                       )
let comment5 = Comment(by: "Example User",
                       id: 35016553,
                       kids: nil,
                       parent: 35015624,
                       text: "Hello this is just an example",
                       time: 1677887295,
                       type: .comment,
                       deleted: false)
let comment6 = Comment(by: "Example User",
                       id: 35016553,
                       kids: nil,
                       parent: 35015624,
                       text: "Hello this is just an example",
                       time: 1677887295,
                       type: .comment,
                       deleted: false)
let dummyComments = [comment1, comment2, comment3, comment4, comment5, comment6]
