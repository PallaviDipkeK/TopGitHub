//
//  JsonFileResponse.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 29/10/21.
//

import Foundation
// ************************ MARK: - TimeResponse ************************ //
struct TimeResponse: Codable {
    var time: String?
    var isSelected: Bool
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case isSelected = "isSelected"
    }
}

// ************************ MARK: - LanguageResponse ************************ //
class LanguageResponse: Codable, Hashable, Equatable {
    let language_Name: String?
    var selected: Bool? = false
    var hashValue: Int {
        return language_Name.hashValue
    }
    
    static func == (left: LanguageResponse, right: LanguageResponse) -> Bool {
        return left.language_Name == right.language_Name
    }
}

extension LanguageResponse: FilterProtocol {
    var isSelected: Bool {
        get {
            return selected ?? false
        }
        set {
            selected = newValue
        }
    }
    
    var title: String? {
        return language_Name
    }
}
