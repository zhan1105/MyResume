//
//  MyUnitProtocol.swift
//  MyResume
//
//  Created by 立大資訊 on 2024/6/26.
//

import SwiftUI

protocol MyUnitProtocol: Codable, Identifiable, CaseIterable, View, RawRepresentable where RawValue == String, AllCases: RandomAccessCollection {
    associatedtype T: Dimension
    
    static var userDefaultsKey: UserDefaults.key { get }
    static var defaultUnit: Self { get }
    
    var dimension: T { get }
}

extension MyUnitProtocol {
    static func getPreferredUnit(from store: UserDefaults = .standard) -> Self {
        AppStorage(userDefaultsKey, store: store).wrappedValue
    }
}

extension MyUnitProtocol {
    var localizedSymbol: String {
        MeasurementFormatter().string(from: dimension)
    }
    
    var body: some View {
        Text(localizedSymbol)
    }
}

extension MyUnitProtocol {
    var id: Self { self }
}

