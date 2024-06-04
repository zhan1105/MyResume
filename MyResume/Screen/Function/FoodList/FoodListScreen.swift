//
//  FoodListView.swift
//  FoodPicker
//
//  Created by 立大資訊 on 2024/5/28.
//

import SwiftUI

struct FoodListScreen: View {
    
    @State private var editMode: EditMode = .inactive
    @AppStorage(.foodList) private var food = Food.examples
    @State private var selectedFoodID = Set<UUID>()
    @State private var sheetType: SheetType?
    
    var isEditing: Bool { editMode.isEditing }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            titleBar
            
            List($food, id: \.id, editActions: .all, selection: $selectedFoodID, rowContent: buildFoodRow)
                .listStyle(.plain)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.groupBg2)
                        .ignoresSafeArea()
                }
                .padding(.horizontal)
            
            
        }
        .background(Color.groupBg)
        .safeAreaInset(edge: .bottom) { buildFolatButton() }
        .environment(\.editMode, $editMode)
        .sheet(item: $sheetType){ $0 }
    }
}

//MARK: - SubView
private extension FoodListScreen {
    
    var titleBar: some View {
        HStack {
            Label("食物清單", systemImage: .forkAndKnife)
                .font(.title)
                .bold()
                .foregroundStyle(Color(.accent))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            EditButton()
                .buttonStyle(BorderedButtonStyle())
            
            addButton
        }
        .padding()
    }
    
    var addButton: some View {
        Button {
            sheetType = .newFood{ food.append($0) }
        } label: {
            Image(systemName: .plus)
                .font(.system(size: 40))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, Color.accentColor.gradient)
        }
    }
    
    var removeButton: some View {
        Button {
            withAnimation {
                food = food.filter { !selectedFoodID.contains($0.id) }
            }
        } label: {
            Text("刪除已選項目")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
        }.mainButtonStyle(shape: .roundedRectangle(radius: 8))
            .padding(.horizontal, 50)
            .padding(.bottom)
    }
    
    func buildFolatButton() -> some View {
        
        removeButton
            .transition(.moveLeadingWithOpacity.animation(.easeInOut))
            .opacity(isEditing ? 1 : 0)
            .id(isEditing)
    }
    
    func buildFoodRow(foodBinding: Binding<Food>) -> some View {
        let food = foodBinding.wrappedValue
        return HStack {
            Text(food.name)
                .font(.title3)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    if isEditing {
                        selectedFoodID.insert(food.id)
                        return
                    }
                    sheetType = .foodDetail(food)
                }
            
            if isEditing {
                Image(systemName: .pencil)
                    .font(.title2.bold())
                    .foregroundStyle(Color.accentColor)
                    .onTapGesture {
                        sheetType = .edutFood(foodBinding)
                    }
            }
        }.listRowBackground(Color.clear)
        
    }
}



#Preview {
    FoodListScreen()
}
