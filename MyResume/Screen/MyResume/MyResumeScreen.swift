//
//  ContentView.swift
//  MyResume
//
//  Created by 立大資訊 on 2024/6/4.
//

import SwiftUI

struct MyResumeScreen: View {
    
    @State private var isShowContact = false
    
    let myProfile = Resume.shared
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack (spacing: 30){
                    
                    myResumeView
                    
                    Text(myProfile.bio)
                        .font(.headline)
                        .lineSpacing(10)
                    
                    myContactInfoBtn
                    
                    mySkills
                    
                    myExperience
                    
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight:  proxy.size.height)
                .overlay(Color.black.opacity(isShowContact ? 0.5 : 0)
                    .onTapGesture { isShowContact = false })
                .overlay{ contactView }
                .animation(.spring, value: isShowContact)

            }
            .background(Color(uiColor: .secondarySystemBackground))
        }
    }
}

//MARK: - SubView
extension MyResumeScreen {
    
    var myResumeView: some View {
        HStack {
            Image("avatar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 160)
                
            VStack(spacing: 15){
                Text(myProfile.name)
                    .font(.title)
                    .bold()
                
                Text(myProfile.title)
                
                Text(myProfile.graduate)
                    .font(.callout)
                
                Label(myProfile.location, systemImage: "location.fill")
                    .foregroundStyle(Color.secondary)
                    .bold()
                
            }
        }
    }
    
    var myContactInfoBtn: some View {
        
        Button {
            isShowContact = true
        } label: {
            Text("Contact Me")
                .font(.title2)
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.white)
                .bold()
                .padding(.vertical, 10)
        }
        .background(RoundedRectangle(cornerRadius: 20))
        .foregroundStyle(Color.brown)
    }
    
    var mySkills: some View {
        VStack {
            Text("Skills")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)

            
            HStack(spacing: 50){
                ForEach(myProfile.skills, id: \.self) { skill in
                    mySkillsView(picture: skill)
                }
            }
        }
        .frame(height: 125)
    }
    
    var myExperience: some View {
        VStack {
            Text("Experience")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
            
            VStack {
                ForEach(myProfile.experiences, id: \.title){ exp in
                    
                    HStack(spacing: 20) {
                        
                        Circle().frame(width: 10)
                            .padding(.horizontal)
                        
                        VStack(spacing: 8) {
                            Group {
                                Text("\(exp.start) - \(exp.end)")
                                    .foregroundStyle(Color.secondary)
                                Text(exp.title)
                                    .bold()
                                Text(exp.company)
                                    .padding(.bottom)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }.padding(.top)
        }
    }
    
    var contactView: some View {
        Group{
            if isShowContact {
                ContactView(isShowContact: $isShowContact)
                    .transition(.slide)
            }
        }
    }
    
    func mySkillsView(picture: String) -> some View {
       
        VStack {
            Image(picture)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(picture)
        }
    }
}

#Preview {
    MyResumeScreen()
}

