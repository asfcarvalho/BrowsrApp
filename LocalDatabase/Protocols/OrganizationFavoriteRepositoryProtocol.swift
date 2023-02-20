//
//  OrganizationFavoriteRepositoryProtocol.swift
//  LocalDatabase
//
//  Created by Anderson F Carvalho on 20/02/23.
//

import Foundation

public protocol OrganizationFavoriteRepositoryProtocol {
    func saveFavorite(_ id: Int, completionBlock: (Result<Void, Error>) -> Void)
    func removeFavorite(_ id: Int, completionBlock: (Result<Void, Error>) -> Void)
    func getIsFavorite(_ id: Int, completionBlock: (Result<Bool, Error>) -> Void)
    func getAllFavorite(completionBlock: (Result<[Int], Error>) -> Void)
}
