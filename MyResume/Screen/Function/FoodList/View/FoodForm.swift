//
//  FoodForm.swift
//  FoodPicker
//
//  Created by 立大資訊 on 2024/5/30.
//

import SwiftUI

extension FoodListScreen {
    struct FoodForm: View {
        @Environment(\.dismiss) var dismiss
        @FocusState private var field: MyField?
        @State var title = "食物資訊"
        @State var food: Food
        var onSubmit: (Food) -> Void
        
        private var isNotSave: Bool {
            food.name.isEmpty || food.image.count > 2
        }
        
        private var errorMessage: String? {
            if food.name.isEmpty { return "請輸入名稱" }
            if food.image.count > 2 { return "圖片長度過長" }
            return .none
        }
        
        var body: some View {
            NavigationStack{
                VStack {
                    
                    titleBar
                    
                    formView
                    
                    saveButton
                    
                }
                .background(Color.groupBg)
                .multilineTextAlignment(.trailing)
                .font(.title3)
                .scrollDismissesKeyboard(.interactively)
                .toolbar(content: keyboardTools)
            }
        }
        
        
    }
}



//MARK: - SubVIew
extension FoodListScreen.FoodForm {
    
    var titleBar: some View {
        HStack {
            Label(title, systemImage: .pencil)
                .font(.title.bold())
                .foregroundStyle(Color.accentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: .xmark)
                .font(.title)
                .foregroundStyle(Color.secondary)
                .onTapGesture {
                    dismiss()
                }
        }.padding([.horizontal, .top])
    }
    
    var formView: some View {
        
        Form {
            
            LabeledContent("名稱") {
                TextField("必填", text: $food.name)
                    .focused($field, equals: .title)
            }
            
            LabeledContent("圖示") {
                TextField("最多輸入2個字元", text: $food.image)
                    .focused($field, equals: .image)
            }
            
            buildInfoField(title: "熱量", value: $food.$calorie, field: .caloriew)
            buildInfoField(title: "蛋白質", value: $food.$protein, field: .protein)
            buildInfoField(title: "脂肪", value: $food.$fat, field: .fat)
            buildInfoField(title: "碳水", value: $food.$carb, field: .carb)
                
        }.padding(.top, -15)
    }
    
    var saveButton: some View {
        Button {
            dismiss()
            onSubmit( food )
        } label: {
            Text(errorMessage ?? "儲存")
                .bold()
                .frame(maxWidth: .infinity)
        }
        .mainButtonStyle()
        .padding()
        .disabled(isNotSave)
    }
    
    var previousBtn: some View {
        Button(action: {
            goPreviousField()
        }, label: {
            Image(systemName: .chevronUp)
        })
    }
    
    var nextBtn: some View {
        Button(action: {
            goNextField()
        }, label: {
            Image(systemName: .chevronDown)
        })
    }
    
    private func goPreviousField() {
        guard let rawValue = field?.rawValue else { return }
        field = .init(rawValue: rawValue - 1)
    }
    
    private func goNextField() {
        guard let rawValue = field?.rawValue else { return }
        field = .init(rawValue: rawValue + 1)
    }
    
    private func buildInfoField<Unit: MyUnitProtocol & Hashable>
                                       (title:  String,
                                        hint:   String = "",
                                        value:  Binding<Suffix<Unit>>,
                                        field:  MyField) -> some View {
        
        LabeledContent(title) {
            HStack {
                TextField(hint, value: Binding(
                    get: { value.wrappedValue.wrappedValue },
                    set: { value.wrappedValue.wrappedValue = $0 }),
                          format:.number.precision(.fractionLength(1)))
                .focused($field, equals: field)
                .keyboardType(.numbersAndPunctuation)
                
                if Unit.allCases.count <= 1 {
                    value.unit.wrappedValue
                }else{
                    Picker("單位", selection: value.unit) {
                        ForEach(Unit.allCases)
                    }
                    .labelsHidden()
                }
            }
        }
    }
    
    func keyboardTools() -> some ToolbarContent {
        ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            
            previousBtn
    
            nextBtn
        }
    }
}

//MARK: - Focus Handling
private extension TextField where Label == Text {
    func focused(_ field: FocusState<MyField?> .Binding, equals this: MyField) -> some View{
        submitLabel(this == .carb ? .done : .next)
            .focused(field, equals: this)
            .onSubmit {
                field.wrappedValue = .init(rawValue: this.rawValue + 1)
            }
    }
}

private enum MyField: Int {
    case title, image, caloriew, protein, fat, carb
}


#Preview {
    FoodListScreen.FoodForm(title: "食物資訊", food: Food.examples.first!){  _ in  }
}
