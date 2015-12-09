//
//  Topic.swift
//  ArlandaRC
//
//  Created by Fabian Östlund on 09/12/15.
//  Copyright © 2015 Arlanda RC. All rights reserved.
//

import Foundation

class Topic {
    var title: String
    var category: String
    var posts: [Post]
    
    init(topicTitle: String, topicCategory: String, topicPosts: [Post]) {
        title = topicTitle
        category = topicCategory
        posts = topicPosts
    }
}

class Post {
    var author: String
    var message: String
    var date: String
    
    init(postAuthor: String, postMessage: String, postDate: String) {
        author = postAuthor
        message = postMessage
        date = postDate
    }
}