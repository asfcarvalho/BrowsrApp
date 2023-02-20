//
//  Model+Organization.swift
//  BrowsrLib
//
//  Created by Anderson F Carvalho on 20/02/23.
//

import Foundation

public extension Model {
    struct Organizatiion: Hashable {
        public let id: Int
        public let login: String
        public let nodeId: String
        public let avatarUrl: String
        public var isFavorite: Bool = false
        
        public init(id: Int, login: String, nodeId: String, avatarUrl: String) {
            self.id = id
            self.login = login
            self.nodeId = nodeId
            self.avatarUrl = avatarUrl
        }
    }
}
