//
//  UserDefaults+PropertyWrappers.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 22/02/2022.
//

import Foundation

@propertyWrapper
struct UserDefault<T> where T: Codable {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.codable(forKey: key) ?? defaultValue
        }
        set {
            UserDefaults.standard.set(value: newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    func set<Element: Codable>(value: Element, forKey key: String) {
        let data = try? JSONEncoder().encode(value)
        UserDefaults.standard.setValue(data, forKey: key)
    }

    func codable<Element: Codable>(forKey key: String) -> Element? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        do {
            let element = try JSONDecoder().decode(Element.self, from: data)
            return element
        } catch {
            print("Error in codable user defaults: \(error.localizedDescription)")
        }
        return nil
    }
}
