//
//  View.swift
//  MyResume
//
//  Created by 立大資訊 on 2024/6/3.
//

import SwiftUI

extension View {
    
    func myImage(picture: String) -> some View {
        Image(picture)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    func mySystemImage(name: String) -> some View {
        Image(systemName: name)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    func mainButtonStyle(shape: ButtonBorderShape = .capsule) -> some View{
        buttonStyle(BorderedProminentButtonStyle())
        .buttonBorderShape(shape)
        .controlSize(.large)
    }
    
    func roundedRactBackground(radios: CGFloat = 8,
                               style: some ShapeStyle = Color.bg) -> some View {
        background(RoundedRectangle(cornerRadius: radios)
            .foregroundStyle(style))
    }
    
    func readGeometry<Key: PreferenceKey, Value>(keyPath: KeyPath<GeometryProxy, Value>, key: Key.Type) -> some View where Key.Value == Value {
        overlay {
            GeometryReader { proxy in
                Color.clear.preference(key: key,
                                       value: proxy[keyPath: keyPath])
            }
        }
    }
    
    func mySectionText(text: String, alignment: Alignment = .leading) -> some View {
        
        Text(text)
            .frame(maxWidth: .infinity, alignment: alignment)
            .contentShape(Rectangle())
    }
}
