//
//  SearchViewModel.swift
//  NoribaUI
//
//  Created by a on 11/25/22.
//

import Foundation
import Combine
import NoribaKit

// MARK: Input Protocol
@MainActor
protocol SearchViewModelInput: ObservableObject {
    func onSearchTapped()
}

@MainActor
final class SearchViewModel: ObservableObject {
    
    // MARK: UI State
    @Published var vehicleNumber: String = ""
    @Published var isPresentVehicleResultView = false
    var currentBound: Bound = .hakata
    let bounds = Bound.allCases
    var currentStation: DepartureInfo.DepartureInfo.Data.Station = .shinosaka
    let stations = DepartureInfo.DepartureInfo.Data.Station.sortedMajorStations
    
    enum Bound: String, CaseIterable, Identifiable {
        case hakata = "hakata"
        case tokyo = "tokyo"
        
        var id: String { rawValue }
        
        var title: String {
            switch self {
            case .hakata:
                return "博多方面（下り）"
            case .tokyo:
                return "東京方面（のぼり）"
            }
        }
    }
    
    init() { }
}

extension SearchViewModel: SearchViewModelInput {
    func onSearchTapped() {        
        isPresentVehicleResultView = true
    }
}

extension DepartureInfo.DepartureInfo.Data.Station: Identifiable {
    public var id: String { rawValue }
}
