//
//  ContactView.swift
//  MyResume
//
//  Created by 立大資訊 on 2024/6/3.
//

import SwiftUI

struct ContactView: View {
    
    let myProfile = Resume.shared
    @Binding var isShowContact: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                
                mySystemImage(name: "phone.fill")
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.brown))
                    .onTapGesture{
                        openUrl(myProfile.phoneUrl)
                    }
                
                ForEach(myProfile.socialMedia, id: \.name){ media in
                    
                    myImage(picture: media.name.lowercased())
                        .onTapGesture { openUrl(media.url) }
                }
            }.frame(height: 80)
            
            Text("取消")
                .font(.title3)
                .foregroundStyle(Color.secondary)
                .padding(.top)
                .onTapGesture {
                   isShowContact = false
                }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(Color.white))
        .padding()
    }
    
    func openUrl(_ url: String){
        
        let url = URL(string: url)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return
        }
        print("無效或錯誤連結，無法開啟")
    }
}



#Preview {
    ContactView(isShowContact: .constant(true))
}
