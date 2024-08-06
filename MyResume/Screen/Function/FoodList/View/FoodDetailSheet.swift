//
//  FoodDetailSheet.swift
//  FoodPicker
//
//  Created by 立大資訊 on 2024/6/11.
//

import SwiftUI

extension FoodListScreen {
    private struct FoodDetailSheetHeightKey: PreferenceKey {
        static var defaultValue: CGFloat = 300
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    struct FoodDetailSheet: View {
        
        @Environment(\.dynamicTypeSize) private var textSize
        @State private var foodDetailHeight: CGFloat = FoodDetailSheetHeightKey.defaultValue

        let food : Food

        var body: some View {
            
            let isUseVStack = textSize.isAccessibilitySize || food.image.count > 1
            
            AnyLayout.useVStack(if: isUseVStack, spacing: 30) {
                Text(food.image)
                    .font(.system(size: 100))
                    .lineLimit(1)
                    .minimumScaleFactor(isUseVStack ? 1 : 0.5)
                
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    
                    buildNutritionView(title: "熱量", value: food.$calorie.description)
                    buildNutritionView(title: "蛋白質", value: food.$protein.description)
                    buildNutritionView(title: "脂肪", value: food.$fat.description)
                    buildNutritionView(title: "碳水", value: food.$carb.description)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.groupBg2)
            .readGeometry(keyPath: \.size.height, key: FoodDetailSheetHeightKey.self)
            .onPreferenceChange(FoodDetailSheetHeightKey.self) {
                foodDetailHeight = $0
            }
            .presentationDetents([.height(foodDetailHeight)])
        }
        
        func buildNutritionView(title: String, value: String) -> some View {
            
            GridRow {
                Text(title).gridCellAnchor(.leading)
                Text(value).gridCellAnchor(.trailing)
            }
        }
    }
}
