//
//  OrganizationFavoriteStorageRepository.swift
//  LocalDatabase
//
//  Created by Anderson F Carvalho on 20/02/23.
//

import Foundation

public final class OrganizationFavoriteStorageRepository: BaseStorageRepository, OrganizationFavoriteRepositoryProtocol {
    public func saveFavorite(_ id: Int, completionBlock: (Result<Void, Error>) -> Void) {
        let realm = self.realm
        
        do {
            try realm.write {
                let new = id.asFavoriteRLM()
                realm.add(new)
                completionBlock(.success(()))
            }
        } catch {
            completionBlock(.failure(error))
        }
    }
    
    public func removeFavorite(_ id: Int, completionBlock: (Result<Void, Error>) -> Void) {
        let realm = self.realm
        
        do {
            try realm.write {
                let objects = realm.objects(OrganizationFavoriteRLM.self).filter("favoriteId == %@", id)
                realm.delete(objects)
                completionBlock(.success(()))
            }
        } catch {
            completionBlock(.failure(error))
        }
    }
    
    public func getIsFavorite(_ id: Int, completionBlock: (Result<Bool, Error>) -> Void) {
        let realm = self.realm
        let objects = realm.objects(OrganizationFavoriteRLM.self).filter("favoriteId == %@", id).first
        
        completionBlock(.success(objects != nil))
    }
    
    public func getAllFavorite(completionBlock: (Result<[Int], Error>) -> Void) {
        let realm = self.realm
        let objects = realm.objects(OrganizationFavoriteRLM.self)
        
        completionBlock(.success(objects.asFavoriteArray()))
    }
}
