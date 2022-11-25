//
//  TrainInfoAPI.swift
//  NoribaKit
//
//  Created by a on 11/23/22.
//

import Foundation

public final class TrainInfoAPI {
    private var session = URLSession.shared
    
    private let behave: Behave
    public typealias Station = DepartureInfo.DepartureInfo.Data.Station
    
    // MARK: public
    
    public enum Behave {
        case mock, `default`
    }
    
    public init(_ behave: Behave = .default) {
        self.behave = behave
    }
    
    public func fetchDepartureInfo(bound: Bound,
                                   station: Station) async throws -> DepartureInfo {
        let data: Data
        if behave == .mock {
            data = TrainInfoAPIMocks.fetchDepartureInfoString.data(using: .utf8)!
        } else {
            (data, _) = try await request(url: "https://traininfo.jr-central.co.jp/shinkansen/var/train_info/departure_info_sot_\(station.rawValue)_\(bound.rawValue).json")
        }
        

        let decoder = JSONDecoder()
        return try! decoder.decode(DepartureInfo.self, from: data)
    }
    
    // MARK: private
    
    private func request(url: String) async throws -> (Data, URLResponse) {
        try await session.data(from: URL(string: url)!)
    }
    
}
