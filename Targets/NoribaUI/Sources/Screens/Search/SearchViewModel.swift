//
//  SearchViewModel.swift
//  NoribaUI
//
//  Created by a on 11/25/22.
//

import Foundation
import Combine

// MARK: Input Protocol
@MainActor
protocol SearchViewModelInput: ObservableObject {
    var uiState: SearchViewInputUiState { get set }

    func onSearchTapped()
}

// MARK: UI State
final class SearchViewInputUiState: ObservableObject {
    @Published var vehicleNumber: String = ""
    var currentBound: Bound = .hakata
    var isPresentVehicleResultView = false
    let bounds = Bound.allCases
    
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
    enum Field: Hashable {
        case vehicleNumber
    }
}

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var uiState: SearchViewInputUiState // private(set)にしたい
    
    init() {
        self.uiState = SearchViewInputUiState()
    }
}

extension SearchViewModel: SearchViewModelInput {
    func onSearchTapped() {
        uiState.isPresentVehicleResultView = true
    }
}
