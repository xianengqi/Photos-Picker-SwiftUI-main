//
//  CoreDataStack.swift
//  PHPicker Demo
//
//  Created by Yang Xu on 2023/2/8.
//

import CoreData
import Foundation

final class CoreDataStack {
    let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Load model error: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    init() {}

    func saveImage(data: Data) async {
        await container.performBackgroundTask { context in
            let image = DBImage(context: context)
            image.data = data
            image.timestamp = .now
            do {
                try context.save()
            } catch {
                print("Save image to DB error :\(error.localizedDescription)")
            }
        }
    }

    func deleteImage(for id: NSManagedObjectID) async {
        await container.performBackgroundTask { context in
            guard let image = try? context.existingObject(with: id) as? DBImage else {
                print("Get ID form DB error")
                return
            }
            context.delete(image)
            do {
                try context.save()
            } catch {
                print("Delete image from DB error :\(error.localizedDescription)")
            }
        }
    }
}
