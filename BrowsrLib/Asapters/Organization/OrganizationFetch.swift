//
//  OrganizationFetch.swift
//  BrowsrLib
//
//  Created by Anderson F Carvalho on 20/02/23.
//

import Foundation

public class OrganizationFetch: OrganizationFetchProtocol {
    
    public init() { }
    
    public func organizationFetch(callBack: @escaping (Result<[Model.Organizatiion], Error>) -> Void) {
        OrganizationDataSource.shared.organizationsFetch { result in
            switch result {
            case .success(let success):
                callBack(.success(success.asOrganizationArray()))
            case .failure(let failure):
                callBack(.failure(failure))
            }
        }
    }
}
