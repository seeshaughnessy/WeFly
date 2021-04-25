//
//  WeFlyApp.swift
//  WeFly
//
//  Created by Chris Shaughnessy on 4/12/21.
//

import SwiftUI

@main
struct WeFlyApp: App {
  @StateObject private var flightResultsVM = FlightResultsViewModel()
  
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environmentObject(flightResultsVM)
        }
    }
}
