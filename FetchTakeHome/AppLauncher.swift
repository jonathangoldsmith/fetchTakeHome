//
//  AppLauncher.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/31/24.
//

import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            FetchTakeHomeApp.main()
        } else {
            TestApp.main()
        }
    }
}
