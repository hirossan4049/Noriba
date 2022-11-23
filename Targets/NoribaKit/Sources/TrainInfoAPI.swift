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
    
    // MARK: public
    
    public enum Behave {
        case mock, `default`
    }
    
    public init(_ behave: Behave = .default) {
        self.behave = behave
    }
    
    public func fetchDepartureInfo() async throws -> DepartureInfo {
//        let (data, _) = try await request(url: "")
        
        let data = TrainInfoAPIMocks.fetchDepartureInfoString.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        return try! decoder.decode(DepartureInfo.self, from: data)
        
    }
    
    // MARK: private
    
    private func request(url: String) async throws -> (Data, URLResponse) {
        try await session.data(from: URL(string: url)!)
    }
    
}
