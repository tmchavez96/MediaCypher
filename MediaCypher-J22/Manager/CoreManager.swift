//
//  CoreManager.swift
//  MediaCypher-J22
//
//  Created by mac on 2/17/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import CoreData


final class CoreManager {
    
    public static let shared = CoreManager()
    
    private init(){}
    
    // MARK: - Core Data stack
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MediaCypher_J22")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // MARK: Save File image
    func saveContent(_ path:String,_ isVideo:Bool){
        let entity = NSEntityDescription.entity(forEntityName: "Content", in: context)!
        
        let image = Content(entity: entity , insertInto: context)
        image.isVideo = false
        image.path = path
        saveContext()
        print("saved file")
        
    }
    
    func loadAllContent() -> [Content]{
        print("loaded all content from core manager")
        let fetchRequest = NSFetchRequest<Content>(entityName: "Content")
        //var media:[Content] = []
        do {
            let media = try context.fetch(fetchRequest)
            return media
        }catch{
            print(error.localizedDescription)
            return []
        }
    }
    
    func deleteAllContent(){
        print("deleting all content")
        let fetchRequest = NSFetchRequest<Content>(entityName: "Content")
        do {
            let media = try context.fetch(fetchRequest)
            for file in media {
                context.delete(file)
            }
            saveContext()
        }catch{
            print(error.localizedDescription)
            
        }
    }
    

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
