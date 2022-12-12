//
//  CommonInfo.swift
//  NoribaKit
//
//  Created by a on 12/13/22.
//

struct CommonInfo: Codable {
    let screen: Screen
    
    struct Screen: Codable {
        let title: String
        let defaultMessage: String
    }
}
