//
//  GithubRepoListModel.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 27/10/21.
//

import Foundation

struct GithubRepoListModel {
    // *************************** MARK: - Request *************************** //
    struct Request: Codable {
        var lang: String?
        var since: String?
        
        enum CodingKeys: String, CodingKey {
            case lang = "lang"
            case since = "since"
        }
    }
    
  
    // *************************** MARK: - Response *************************** //
    struct Response: Codable {
        let count: Int?
        let msg: String?
        let items: [Item]?
    }
    
    // MARK: - Item
    struct Item: Codable {
        let repo: String?
        let repoLink: String?
        let desc, lang, stars, forks: String?
        let addedStars: String?
        let avatars: [String]?
        
        enum CodingKeys: String, CodingKey {
            case repo
            case repoLink = "repo_link"
            case desc, lang, stars, forks
            case addedStars = "added_stars"
            case avatars
        }
    }
    
    
    
}


