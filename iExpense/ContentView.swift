//
//  ContentView.swift
//  iExpense
//
//  Created by Chris Wu on 5/9/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import SwiftUI

struct SecondView : View {
    @Environment(\.presentationMode) var presentationMode
    var name : String
    
    var body: some View {
        Button("dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false
    var body: some View {
        Button("Show sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Chris")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
