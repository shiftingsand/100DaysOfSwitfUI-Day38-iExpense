//
//  ContentView.swift
//  iExpense
//
//  Created by Chris Wu on 5/9/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import SwiftUI

struct User : Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @State private var currentNumber = 1
    var body: some View {
        Button("Tap count \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
