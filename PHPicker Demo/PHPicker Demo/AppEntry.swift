//
// Created for PHPicker Demo
// by Stewart Lynch on 2022-07-27
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

@main
struct AppEntry: App {
    @StateObject var imagePicker = ImagePicker()
    var body: some Scene {
        WindowGroup {
            StartTabView()
                .environmentObject(imagePicker)
                .environment(\.managedObjectContext, imagePicker.stack.viewContext)
        }
    }
}
