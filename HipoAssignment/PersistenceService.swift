//
//  PersistenceService.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 27.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Core Data stack

class PersistenceService {

    private init() { }
    static let shared = PersistenceService()

    var context: NSManagedObjectContext { return persistentContainer.viewContext }

    lazy var persistentContainer: NSPersistentContainer = {

      let container = NSPersistentContainer(name: "HipoAssignment")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {

              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {

              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
}
