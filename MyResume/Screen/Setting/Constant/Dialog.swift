//
//  Dialog.swift
//  MyResume
//
//  Created by 立大資訊 on 2024/6/26.
//

import SwiftUI

extension SettingScreen {
    enum Dialog: String {
        case resetSettings = "重置設定"
        case resetFoodList = "重置食物清單"
        case inactive
        
        var message: String {
            switch self {
            case .resetSettings:
                return "將重置顏色、單位等設置，\n此操作無法復原，確定進行嘛？"
            case .resetFoodList:
                return "將重置食物清單，\n此操作無法復原，確定進行嘛？"
            case .inactive:
                return ""
            }
        }
    }
}

extension SettingScreen.Dialog: CaseIterable, Identifiable {
    
    func action() {
        switch self {
        case .resetSettings:
            let keys: [UserDefaults.key] = [.isUseDarkMode, .preferredWeightUnit, .startTab]
            for key in keys {
                UserDefaults.standard.removeObject(forKey: key.rawValue)
            }
        case .resetFoodList:
            UserDefaults.standard.removeObject(forKey: UserDefaults.key.foodList.rawValue)
        case .inactive:
            return
        }
    }
    
    static let allCases: [SettingScreen.Dialog] = [.resetSettings, .resetFoodList]
    
    var id: Self { self }
}
