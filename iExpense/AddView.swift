//
//  AddView.swift
//  iExpense
//
//  Created by Chris Wu on 5/11/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses : Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showingAlert = false
    @State private var badNameAlert = false
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id:\.self) { num in
                        Text(num)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing:
                Button("Save") {
                    if self.name.trimmingCharacters(in: .whitespaces).count <= 0 {
                        self.badNameAlert = true
                    } else {
                        if let actualAmount = Int(self.amount) {
                            let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                            self.expenses.items.append(item)
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            self.showingAlert = true
                        }
                    }
                }
            )
        }
            // day 38 - challenge 3
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Hold up!"), message: Text("Please enter an integer number with no decimal for the cost. \"\(self.amount)\" isn't a valid cost."), dismissButton: .default(Text("OK")) {
                self.showingAlert = false
                })
        }
        .alert(isPresented: $badNameAlert) {
            Alert(title: Text("Hold up!"), message: Text("You must enter an expense name!"), dismissButton: .default(Text("OK")) {
                self.badNameAlert = false
                })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
