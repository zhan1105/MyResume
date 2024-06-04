//
//  TabViewScreen.swift
//  MyResume
//
//  Created by 立大資訊 on 2024/6/26.
//

import SwiftUI

struct TabViewScreen: View {
    var body: some View {
        TabView {
            
            buildTabItem(itemText: "畫面1")
            buildTabItem(itemText: "畫面2")
            buildTabItem(itemText: "畫面3")
            buildTabItem(itemText: "畫面4")
        }
    }
}

extension TabViewScreen {
    
    func buildTabItem(itemText: String) -> some View{
        
        Text(itemText)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .font(.title.bold())
            .tabItem {
                Label(itemText, systemImage: .info)
            }
    }
}

#Preview {
    TabViewScreen()
}
