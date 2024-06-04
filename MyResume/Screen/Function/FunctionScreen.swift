//
//  FunctionView.swift
//  MyResume
//
//  Created by 紹郁 on 2024/6/5.
//

import SwiftUI

struct FunctionScreen: View {
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    Section {
                        NavigationLink("食物清單") {
                            FoodListScreen()
                        }
                    } footer: {
                        Text("ListView ( 新增、編輯、刪除、多選刪除、重新排序 ) \nSheet ( 彈出視窗 )")
                    }
                    
                    Section {
                        NavigationLink("TabView") {
                            TabViewScreen()
                        }
                    } footer: {
                        Text("下選單畫面切換")
                    }
                    
                    Section {
                        NavigationLink("SideMenu") {
                            SideMenuScreen()
                        }
                    } footer: {
                        Text("測選單彈出視窗")
                    }
                    
                    Section {
                        NavigationLink("第三方登入") {
                            LoginView()
                        }
                    } footer: {
                        Text("Apple、Line、google、FB")
                    }
                }
                .bold()
            }
            .navigationTitle("功能展示")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FunctionScreen()
}
