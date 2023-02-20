//
//  Organization+Mapper.swift
//  BrowsrLib
//
//  Created by Anderson F Carvalho on 20/02/23.
//

import Foundation

internal extension Organization {
    func asOrganization() -> Model.Organizatiion {
        Model.Organizatiion(id: id,
                            login: login,
                            nodeId: nodeID,
                            avatarUrl: avatarURL)
    }
}

public extension Sequence where Element == Organization {
    
    func asOrganizationArray() -> [Model.Organizatiion] {
        self.map { $0.asOrganization() }
    }
    
}
