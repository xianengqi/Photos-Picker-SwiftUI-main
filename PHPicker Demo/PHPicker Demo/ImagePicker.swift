//
// Created for PHPicker Demo
// by Stewart Lynch on 2022-07-27
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI
import PhotosUI
import CoreData

@MainActor
class ImagePicker: ObservableObject {

    let stack = CoreDataStack()
    
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            Task {
                if !imageSelections.isEmpty {
                    try await loadTransferable(from: imageSelections)
                    imageSelections = []
                }
            }
        }
    }
    
    func loadTransferable(from imageSelections: [PhotosPickerItem]) async throws {
        do {
            for imageSelection in imageSelections {
                if let data = try await imageSelection.loadTransferable(type: Data.self) {
                    await stack.saveImage(data: data)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteImage(for id:NSManagedObjectID) async {
        await stack.deleteImage(for: id)
    }
}
