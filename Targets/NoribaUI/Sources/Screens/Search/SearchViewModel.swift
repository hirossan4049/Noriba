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
}

@MainActor
final class SearchViewModel: ObservableObject {
    
    // MARK: UI State
    @Published var vehicleNumber: String = ""
    @Published var departureInfo: DepartureInfo? = nil
    @Published var currentBound: Bound = .hakata
    @Published var currentStation: DepartureInfo.DepartureInfo.Data.Station = .shinosaka
    let bounds = Bound.allCases
    let stations = DepartureInfo.DepartureInfo.Data.Station.sortedMajorStations
    
    init() {
        Task {
            self.departureInfo = try! await TrainInfoAPI().fetchDepartureInfo()
        }
    }
}

extension SearchViewModel: SearchViewModelInput {
}

extension DepartureInfo.DepartureInfo.Data.Station: Identifiable {
    public var id: String { rawValue }
}

extension Bound: Identifiable {
    public var id: String { rawValue }
}
