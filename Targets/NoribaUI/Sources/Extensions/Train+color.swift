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
            return Color("Hikari")
        case .kodama:
            return Color("Kodama")
        case .nozomi:
            return Color("Nozomi")
        case .dantai:
            return .gray
        case .kaisou:
            return .gray
        case .mizuho:
            return .blue
        case .sakura:
            return Color("Sakura")
        case .tubame:
            return .pink
        case .unknown:
            return .gray
        }
    }
}
