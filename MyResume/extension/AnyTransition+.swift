//
//  AnyTransition.swift
//  FoodPicker
//
//  Created by 立大資訊 on 2024/5/27.
//

import SwiftUI

extension AnyTransition {
    
    static let delayInsertionOpacity = AnyTransition.asymmetric(
        insertion: .opacity
            .animation(.easeInOut(duration: 0.5).delay(0.2)),
        removal: .opacity
            .animation(.easeInOut(duration: 0.4)))
    
    static let moveUpWithOpacity = AnyTransition.move(edge: .top).combined(with: .opacity)
    
    static let moveLeadingWithOpacity = Self.move(edge: .leading).combined(with: .opacity)
}

