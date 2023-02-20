//
//  OrganizationFetchProtocol.swift
//  BrowsrLib
//
//  Created by Anderson F Carvalho on 20/02/23.
//

import Foundation

public protocol OrganizationFetchProtocol {
    func organizationFetch(callBack: @escaping (Result<[Model.Organizatiion], Error>) -> Void)
}
