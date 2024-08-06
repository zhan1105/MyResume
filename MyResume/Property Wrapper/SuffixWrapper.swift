//
//  SuffixWrapper.swift
//  FoodPicker
//
//  Created by 立大資訊 on 2024/5/27.
//

import Foundation

typealias MyEnergy = Suffix<MyEnergyUnit>
typealias MyWeight = Suffix<MyWeightUnit>

@propertyWrapper struct Suffix<Unit: MyUnitProtocol & Equatable>: Equatable {
    var wrappedValue: Double
    var unit: Unit
    var store: UserDefaults = .standard
    
    init(wrappedValue: Double, _ unit: Unit, store: UserDefaults = .standard) {
        self.wrappedValue = wrappedValue
        self.unit = unit
        self.store = store
    }
    
    var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    
    var description: String {
        let preferredUnit = Unit.getPreferredUnit(from: store)
        let measurement = Measurement(value: wrappedValue, unit: unit.dimension)
        let converted = measurement.converted(to: preferredUnit.dimension)
        return converted.value.formatted(.number.precision(.fractionLength(0...1))) + " " + preferredUnit.localizedSymbol
    }
}

extension Suffix: Codable {
    enum CodingKeys: CodingKey {
        case wrappedValue
        case unit
    }
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<Suffix<Unit>.CodingKeys> = try decoder.container(keyedBy: Suffix<Unit>.CodingKeys.self)
        
        self.wrappedValue = try container.decode(Double.self, forKey: Suffix<Unit>.CodingKeys.wrappedValue)
        self.unit = try container.decode(Unit.self, forKey: Suffix<Unit>.CodingKeys.unit)
        
    }
    
    func encode(to encoder: any Encoder) throws {
        var container: KeyedEncodingContainer<Suffix<Unit>.CodingKeys> = encoder.container(keyedBy: Suffix<Unit>.CodingKeys.self)
        
        try container.encode(self.wrappedValue, forKey: Suffix<Unit>.CodingKeys.wrappedValue)
        try container.encode(self.unit, forKey: Suffix<Unit>.CodingKeys.unit)
    }
}
