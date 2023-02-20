//
//  APIStrings.swift
//  BrowsrLib
//
//  Created by Anderson F Carvalho on 20/02/23.
//

import Foundation

public class APIStrings {
    static var baseUrl: String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else {
            fatalError("Could not find BaseURL variable in info.plist")
        }
        return value
    }
    
    static var appToken: String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "AppToken") as? String else {
            fatalError("Could not find AppToken variable in info.plist")
        }
        return value
    }
}
