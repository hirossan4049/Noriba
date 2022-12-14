//
//  TrainInfoAPI.swift
//  NoribaKit
//
//  Created by a on 11/23/22.
//

import Foundation

public final class TrainInfoAPI {
    private var session: URLSession {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: config)
    }
    
    private let behave: Behave
    public typealias Station = DepartureInfo.DepartureInfo.Data.Station
    
    // MARK: public
    
    public enum Behave {
        case mock, `default`
    }
    
    public enum TrainInfoAPIError: Error {
        case serviceSuspended
        case unknown
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
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(DepartureInfo.self, from: data)
        } catch {
            let (infoData, _) = try await request(url: "https://traininfo.jr-central.co.jp/shinkansen/common/data/ti99f_ja.json")
            let decoder = JSONDecoder()
            let commonInfo = try decoder.decode(CommonInfo.self, from: infoData)
            if commonInfo.screen.defaultMessage.contains("ご提供を一時停止") {
                throw TrainInfoAPIError.serviceSuspended
            } else {
                throw TrainInfoAPIError.unknown
            }
        }
    }
    
    // MARK: private
    
    private func request(url: String) async throws -> (Data, URLResponse) {
        try await session.data(from: URL(string: url)!)
    }
    
}
