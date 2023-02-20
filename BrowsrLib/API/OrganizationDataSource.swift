//
//  OrganizationDataSource.swift
//  BrowsrLib
//
//  Created by Anderson F Carvalho on 20/02/23.
//

import Foundation

public class OrganizationDataSource {
    public static let shared = OrganizationDataSource()
    private var token = CancelBag()
    private let url = "organizations"
    
    let URLDefault = APIStrings.baseUrl
        
    public func organizationsFetch(callBack: @escaping (Result<Organizations, Error>) -> Void) {
        
        let apiRequest = APIRequest()
        let urlString = "\(URLDefault)\(url)"
        apiRequest.baseURL = URL(string: urlString)
        
        APICalling().fetch(apiRequest: apiRequest)
            .sink(receiveCompletion: { error in
                switch error {
                case .finished:
                    break
                case .failure(let error):
                    callBack(.failure(error))
                }
            }, receiveValue: { response in
                callBack(.success(response))
            }).store(in: token)
    }
}
