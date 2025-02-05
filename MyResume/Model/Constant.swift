//
//  Constant.swift
//  MyResumeApp
//
//  Created by Jane Chao on 22/04/20.
//

import Foundation
import SwiftUI

typealias Experience = (title: String, company: String, start: String, end: String)
typealias Function = (title: String, footer: String)

struct Resume {
    static let shared = Resume()
    let name     = "詹紹郁"
    let title    = "iOS Developer"
    let location = "台中市北區"
    let graduate = "勤益科技大學-電子工程系"
    let bio      = "現在正在一邊自學 SwiftUI，一邊加深 Swift中，希望讓自己更上一層樓，並投入到更頂尖的工作中 😊"
    let skills   = ["Swift", "SwiftUI", "Objective-C"]
    let experiences: [Experience] = [("App Developer", "立大資訊網路股份有限公司", "2022 年 11 月", "2024 年 7 月"),
                                     ("iOS 研發人員", "美家人力資源股份有限公司", "2024 年 8 月", "至今")]
    
    let function: [Function] = [("ListView",
                                 "新增、編輯、刪除、多選刪除、重新排序"),
                                
                                ("Sheet",
                                 "彈出視窗"),
                                
                                ("TabView",
                                 "下選單畫面切換"),
                                
                                ("SideMenu",
                                 "測選單彈出視窗"),
                                
                                ("第三方登入",
                                 "Apple、Line、google、FB")]
    
    let phoneUrl = "tel://0985732745"
    let socialMedia: [(name: String, url: String)] = [("Line",      "https://line.me/ti/p/j5lKytr_xG"),
                                                      ("Github",    "https://github.com/zhan1105/MyNewResume"),
                                                      ("Figma",     "https://www.figma.com/board/WTID8WVJTGrjdTWJlDFhf7/Untitled?node-id=903-954&t=RXpets6dhg4LfVQR-0")]
}

