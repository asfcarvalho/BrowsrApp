//
//  Favorite+Transform.swift
//  LocalDatabase
//
//  Created by Anderson F Carvalho on 20/02/23.
//

import Foundation

internal extension OrganizationFavoriteRLM {
    func asFavorite() -> Int {
        favoriteId
    }
}

internal extension Sequence where Element == OrganizationFavoriteRLM {
    
    func asFavoriteArray() -> [Int] {
        self.map { $0.asFavorite() }
    }
    
}

internal extension Int {
    func asFavoriteRLM() -> OrganizationFavoriteRLM {
        OrganizationFavoriteRLM.create { favorite in
            favorite.favoriteId = self
        }
    }
}
