//
//  SideMenuScreen.swift
//  MyResume
//
//  Created by 立大資訊 on 2024/6/26.
//

import SwiftUI

struct SideMenuScreen: View {
    @State private var showMenu = false
    
    var body: some View {
        ZStack {
            NavigationView {
                MainView(showMenu: $showMenu)
                    .navigationBarTitle("側選單", displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    })
            }
            
            if showMenu {
                SideMenuView(showMenu: $showMenu)
            }
        }
    }
}

struct MainView: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack {
            
        }
        .background(Color.white)
    }
}

struct SideMenuView: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                Button {
                    withAnimation {
                        self.showMenu = false
                    }
                } label: {
                    Label("返回", systemImage: "arrow.backward")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color.white)
                }
                .padding()
                .background(Color.accentColor)
                
                Spacer()
            }
            .frame(width: 250)
            .background(Color.white.opacity(0.9))
            .offset(x: showMenu ? 0 : -250)
            .animation(.easeInOut, value: showMenu)
            Spacer()
        }
        .background(Color.black.opacity(showMenu ? 0.5 : 0).edgesIgnoringSafeArea(.all))
        .onTapGesture {
            withAnimation {
                self.showMenu = false
            }
        }
    }
}

#Preview {
    SideMenuScreen()
}

