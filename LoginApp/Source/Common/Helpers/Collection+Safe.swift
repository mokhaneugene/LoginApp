//
//  Collection+Safe.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 23/02/2022.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index <  endIndex ? self[index] : nil
    }
}
