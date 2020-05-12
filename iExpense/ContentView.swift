//
//  ContentView.swift
//  iExpense
//
//  Created by Chris Wu on 5/9/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import SwiftUI

struct ExpenseItem : Identifiable, Codable {
    let id = UUID()
    let name : String
    let type : String
    let amount : Int
}

class Expenses : ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

// day 38 - challenge 2
func changeCost(_ cost : Int) -> Text {
    if cost < 10 {
        return Text("$\(cost)")
            .font(.body)
            .foregroundColor(.black)
    } else if cost < 100 {
        return Text("$\(cost)")
            .font(.headline)
            .foregroundColor(.green)
    } else {
        return Text("$\(cost)")
            .font(.largeTitle)
            .foregroundColor(.red)
    }
}

struct Cheapskate : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .background(Color.black)
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        changeCost(item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
                // day 38 challenge 1
                .navigationBarItems(leading: EditButton(), trailing:
                    Button(action: {
                        self.showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
            )
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets : IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
