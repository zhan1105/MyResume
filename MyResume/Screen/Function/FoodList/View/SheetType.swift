//
//  SheetType.swift
//  FoodPicker
//
//  Created by 立大資訊 on 2024/6/11.
//

import SwiftUI

extension FoodListScreen {
    enum SheetType: View, Identifiable {
        case newFood((Food) -> Void)
        case edutFood(Binding<Food>)
        case foodDetail(Food)
        
        var id: Food.ID {
            switch self {
            case .newFood:
                return UUID()
            case .edutFood(let foodBinding):
                return foodBinding.id
            case .foodDetail(let food):
                return food.id
            }
        }
        
        var body: some View {
            switch self {
            case .newFood(let onSubmit):
                FoodForm(title: "新增食物資訊", food: .add, onSubmit: onSubmit)
            case .edutFood(let foodBinding):
                FoodForm(title: "編輯食物資訊", food: foodBinding.wrappedValue) {foodBinding.wrappedValue = $0}
            case .foodDetail(let food):
                FoodDetailSheet(food: food)
            }
        }
    }
}

