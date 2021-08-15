//
//  Settings.swift
//  iSchool
//
//  Created by Алексей Авдейчик on 11.05.21.
//

import Foundation

enum KeyUserDefaults {
    static let settingsGame = "settingGame"
    static let recordGame = "recordGame"
}
struct SettingsGame: Decodable, Encodable {
    var timerState: Bool
    var timeForGame: Int
}


class Settings {
    
    static var shared = Settings()
    
    private let defaultSettings = SettingsGame(timerState: true, timeForGame: 45)
    var currentSettings: SettingsGame {
        get {
            if let data = UserDefaults.standard.object(forKey: KeyUserDefaults.settingsGame) as? Data {
                return try! PropertyListDecoder().decode(SettingsGame.self, from: data)
            } else {
                
                if let data = try? PropertyListEncoder().encode(defaultSettings) {
                    UserDefaults.standard.setValue(data, forKey: KeyUserDefaults.settingsGame)
                }
                return defaultSettings
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: KeyUserDefaults.settingsGame)
            }
        }
    }
    
    func resetSettings() {
        currentSettings = defaultSettings
    }
}
