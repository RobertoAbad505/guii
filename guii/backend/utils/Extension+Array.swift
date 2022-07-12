//
//  Extension+Array.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//

import Foundation

extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element] {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
}
