import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model") // имя .xcdatamodeld файла
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Ошибка при загрузке хранилища: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Ошибка при сохранении: \(error)")
            }
        }
    }
}
