//
//  DataPersistenceManager.swift
//  NetflixCloneApp
//
//  Created by Tolga on 20.11.2022.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveCoreData
        case failedToFetchFromCoreData
        case failtedToDeleteCoreData
        case failedToCheckDownloadedData
    }
    
    static let shared = DataPersistenceManager()
    
    
    func downloadTitleWith(model: Title, completion: @escaping(Result<Void, Error>) -> Void ) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.id = Int64(model.id!)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count!)
        item.vote_average = model.vote_average!
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveCoreData))
        }
       
    }
    
    func fetchTitlesFromCoreData(completion: @escaping(Result<[TitleItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(DatabaseError.failedToFetchFromCoreData))
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping(Result<Void, Error>) -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failtedToDeleteCoreData))
        }
    }
    
    func isDownloaded(_ id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<TitleItem> = TitleItem.fetchRequest()
        let predicate = NSPredicate(format: "(id = %@)", NSNumber(value: id))
        fetchRequest.predicate = predicate
            
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
            
        let context = appDelegate.persistentContainer.viewContext
            
            do {
                let result = try context.fetch(fetchRequest).first
                
                if let _ = result {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
                
            } catch {
                completion(.failure(DatabaseError.failedToCheckDownloadedData))
            }
        }
    
}
