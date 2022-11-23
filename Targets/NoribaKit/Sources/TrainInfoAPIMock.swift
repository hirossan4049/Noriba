//
//  TrainInfoAPIMock.swift
//  NoribaKit
//
//  Created by a on 11/23/22.
//

import Foundation

private protocol TrainInfoAPIMocksProtocol {
    static var fetchDepartureInfoString: String { get }
}

final class TrainInfoAPIMocks: TrainInfoAPIMocksProtocol {
    static var fetchDepartureInfoString: String {
        // /departure_info_sot_{bound}_{station}.json
        // https://traininfo.jr-central.co.jp/shinkansen/var/train_info/departure_info_sot_1_2.json
        guard let url = Bundle.main.url(forResource: "departureInfoMock", withExtension: "json") else { fatalError() }
        return try! String(contentsOf: url)
    }
}
