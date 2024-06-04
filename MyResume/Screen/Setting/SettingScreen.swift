//
//  SettingScreen.swift
//  MyResume
//
//  Created by 立大資訊 on 2024/6/26.
//

import SwiftUI

struct SettingScreen: View {
    
    @AppStorage(.isUseDarkMode) private var isUseDarkMode: Bool = false
    @AppStorage(.preferredWeightUnit) private var unit: MyWeightUnit
    @AppStorage(.startTab) private var startTab: HomeScreen.Tab = .myResume
    @State private var DialogView: Dialog = .inactive
    
    private var isShowDialog: Binding<Bool> {
        Binding {
            DialogView != .inactive
        } set: { _ in
            DialogView = .inactive
        }
    }
    
    var body: some View {
        Form {
            Section("基本設定"){
                Toggle(isOn: $isUseDarkMode) {
                    Label("深色模式", systemImage: .moon)
                }
                Picker(selection: $unit) {
                    ForEach(MyWeightUnit.allCases) { $0 }
                } label: {
                    Label("單位", systemImage: .nuitSign)
                }
                
                Picker(selection: $startTab) {
                    Text("我的履歷").tag(HomeScreen.Tab.myResume)
                    Text("功能展示").tag(HomeScreen.Tab.function)
                } label: {
                    Label("啟動畫面", systemImage: .house)
                }
            }
            
            Section("進階設定"){
                ForEach(Dialog.allCases) { dialog in
                    Button(dialog.rawValue) {
                        DialogView = dialog
                    }
                    .tint(Color(.label))
                }
            }
            .confirmationDialog(DialogView.rawValue,
                                isPresented: isShowDialog,
                                titleVisibility: .hidden) {
                Button("確定", role: .destructive, action: DialogView.action)
            } message: {
                Text(DialogView.message)
            }
        }
    }
}

#Preview {
    SettingScreen()
}
