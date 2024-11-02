//
//  TestApp.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/31/24.
//

import SwiftUI

/// Used so that the test suite does not open up the RecipleListView
/// and run tasks in the background while the test suite is running
struct TestApp: App {
    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}
