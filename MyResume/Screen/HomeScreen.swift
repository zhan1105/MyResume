//
//  HomeScreen.swift
//  MyResume
//
//  Created by 立大資訊 on 2024/6/12.
//

import SwiftUI

extension HomeScreen {
    enum Tab: String, View, CaseIterable {
        
        case myResume, function, setting
        
        var body: some View {
            content.tabItem { tabLabel }
        }
        
        @ViewBuilder
        private var content: some View {
            switch self {
            case .myResume:
                MyResumeScreen()
            case .function:
                FunctionScreen()
            case .setting:
                SettingScreen()
            }
        }
        
        private var tabLabel: some View {
            switch self {
            case .myResume:
                return Label("Home", systemImage: .house)
            case .function:
                return Label("List", systemImage: .list)
            case .setting:
                return Label("Setting", systemImage: .gear)
            }
        }
    }
}

struct HomeScreen: View {
    
    @AppStorage(.isUseDarkMode) var isUseDarkMode = false
    @State var tabItem: Tab = {
        let rawValue = UserDefaults.standard.string(forKey: UserDefaults.key.startTab.rawValue) ?? ""
        return Tab(rawValue: rawValue) ?? .myResume
    }()
    
    var body: some View {
        NavigationStack{
            TabView(selection: $tabItem) {
                ForEach(Tab.allCases, id: \.self) { $0 }
            }
            .preferredColorScheme(isUseDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    HomeScreen()
}
