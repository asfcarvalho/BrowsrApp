//
//  BaseStorageRepository.swift
//  LocalDatabase
//
//  Created by Anderson F Carvalho on 20/02/23.
//

import Foundation
import RealmSwift

public class BaseStorageRepository {
    
    public let configuration: Realm.Configuration?
    private static var schemaVersion: UInt64 = 1
    
    private let config = Realm.Configuration(
        schemaVersion: BaseStorageRepository.schemaVersion,
        deleteRealmIfMigrationNeeded: true
    )
    
    public var realm: Realm {
        do {
            return try Realm(configuration: self.configuration ?? self.config)
        } catch let err {
            fatalError(err.localizedDescription)
        }
    }
    
    public init(configuration: Realm.Configuration? = nil) {
        self.configuration = configuration
    }
    
}
