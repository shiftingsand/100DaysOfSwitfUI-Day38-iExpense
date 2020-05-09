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
    @State private var user = User(firstName: "Bilbo", lastName: "Baggins")
    var body: some View {
        Button("Tap count") {
            let encoder = JSONDecoder()
            
            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
