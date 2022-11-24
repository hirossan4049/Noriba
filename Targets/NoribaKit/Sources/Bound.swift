//
//  Bound.swift
//  NoribaUI
//
//  Created by a on 11/25/22.
//


enum Bound: String, CaseIterable {
    case hakata = "2"
    case tokyo = "1"
//    case zyoge = "3"
    
    var title: String {
        switch self {
        case .hakata:
            return "博多方面（下り）"
        case .tokyo:
            return "東京方面（上り）"
        }
    }
}
