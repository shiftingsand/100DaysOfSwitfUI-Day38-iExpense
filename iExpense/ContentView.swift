//
//  ContentView.swift
//  iExpense
//
//  Created by Chris Wu on 5/9/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id:\.self) {
                        Text("\($0)")
                    }
                .onDelete(perform: removeRows)
                }
                
                Button("Add number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }
        .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offsets : IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
