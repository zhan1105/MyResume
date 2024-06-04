//
//  SFSymbol.swift
//  MyResume
//
//  Created by 立大資訊 on 2024/6/12.
//

import SwiftUI

enum SFSymbol: String {
    case pencil         = "pencil"
    case plus           = "plus.circle.fill"
    case chevronUp      = "chevron.up"
    case chevronDown    = "chevron.down"
    case xmark          = "xmark.circle.fill"
    case forkAndKnife   = "fork.knife"
    case info           = "info.circle.fill"
    
    case moon           = "moon.fill"
    case nuitSign       = "numbersign"
    case house          = "house.fill"
    case list           = "list.bullet"
    case gear           = "gearshape"
}

extension Label where Title == Text, Icon == Image {
    init(_ text: String, systemImage: SFSymbol) {
        self.init(text, systemImage: systemImage.rawValue)
    }
}

extension Image {
    init(systemName: SFSymbol){
        self.init(systemName: systemName.rawValue)
    }
}


