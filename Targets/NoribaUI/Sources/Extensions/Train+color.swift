//
//  Train+color.swift
//  Noriba
//
//  Created by a on 12/14/22.
//
import NoribaKit
import struct SwiftUI.Color

extension DepartureInfo.DepartureInfo.Data.Train {
    public var color: Color {
        switch self {
        case .hikari:
            return .red
        case .kodama:
            return .blue
        case .nozomi:
            return .yellow
        case .dantai:
            return .gray
        case .kaisou:
            return .gray
        case .mizuho:
            return .blue
        case .sakura:
            return .pink
        case .tubame:
            return .pink
        case .unknown:
            return .gray
        }
    }
}
