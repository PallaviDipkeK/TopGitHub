//
//  Array+Reusable.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 29/10/21.
//

import Foundation

// MARK: - Array Extension
extension Array {
    
    // MARK: - Methods
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
    func removingDuplicates<T: Hashable>(byKey key: (Element) -> T) -> [Element] {
        var result = [Element]()
        var seen = Set<T>()
        for value in self {
            if seen.insert(key(value)).inserted {
                result.append(value)
            }
        }
        return result
    }
}

public extension Array where Element: Hashable {
    
    // MARK: - Methods
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
