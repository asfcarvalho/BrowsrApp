//
//  OrganizationFavoriteRLM.swift
//  LocalDatabase
//
//  Created by Anderson F Carvalho on 20/02/23.
//

import Foundation
import RealmSwift

@objcMembers
internal class OrganizationFavoriteRLM: Object {
    override class func primaryKey() -> String? {
        #keyPath(OrganizationFavoriteRLM.favoriteId)
    }
    
    @objc internal dynamic var favoriteId: Int = 0
    internal dynamic var login: String = ""
}
