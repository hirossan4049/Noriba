//
//  Navigation.swift
//  NoribaUI
//
//  Created by a on 11/25/22.
//

import Foundation
import NoribaKit

public struct VehicleResultNavigation: Identifiable, Hashable {
    public let id = UUID()
    
    public let trainNumber: String
    public let bound: Bound
    public let station: DepartureInfo.DepartureInfo.Data.Station
}
