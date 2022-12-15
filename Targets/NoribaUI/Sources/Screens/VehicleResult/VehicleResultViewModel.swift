//
//  VehicleResultViewModel.swift
//  NoribaKit
//
//  Created by a on 12/13/22.
//
import Combine
import NoribaKit
import Foundation

public enum VehicleResultViewStatus {
    case success
    case isLoading
    case isServiceSuspended
    case unknownError
}

protocol VehicleResultViewModelInput {
    var status: VehicleResultViewStatus { get }
    var departureInfo: DepartureInfo? { get }
    var resultTrainData: DepartureInfo.DepartureInfo.Data? { get }
    var numberOfRows: Int { get }
    
    func onAppear() async
    func cellForRowAt(section: Int, row: Int) -> (DepartureInfo.DepartureInfo.Data?, id: Int?)
    func getCurrentDateCellId() -> Int?
    func unixtimeToDate(unixtime: Int) -> String
}

public class VehicleResultViewModel: VehicleResultViewModelInput, ObservableObject {
    public let trainNumber: String
    public let bound: Bound
    public let station: DepartureInfo.DepartureInfo.Data.Station
    
    @Published private(set) public var status: VehicleResultViewStatus = .isLoading
    @Published private(set) public var departureInfo: DepartureInfo? = nil
    @Published private(set) public var resultTrainData: DepartureInfo.DepartureInfo.Data? = nil
    @Published private(set) public var numberOfRows: Int = 0
    
    public init(trainNumber: String, bound: Bound, station: DepartureInfo.DepartureInfo.Data.Station) {
        self.trainNumber = trainNumber
        self.bound = bound
        self.station = station
    }
    
    // MARK: VehicleResultViewModelInput
    public func onAppear() async {
         await fetch()
    }
    
    public func cellForRowAt(section: Int, row: Int) -> (DepartureInfo.DepartureInfo.Data?, id: Int?) {
        let departureInfo = departureInfo?.departureInfo.data[row]
        return (departureInfo, departureInfo?.departureTime)
    }
    
    public func getCurrentDateCellId() -> Int? {
        let now = Date()
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let date = hour * 60 + minute
        return departureInfo?.departureInfo.data.lazy.filter({
            $0.departureTime >= date
        }).first?.departureTime
    }
    
    public func unixtimeToDate(unixtime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixtime))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter.string(from: date)
    }
    
    // MARK: private
    @MainActor
    private func fetch() async {
        do {
            departureInfo = try await TrainInfoAPI().fetchDepartureInfo(bound: bound, station: station)
            numberOfRows = departureInfo?.departureInfo.data.count ?? 0
            resultTrainData = departureInfo?.departureInfo.data.first(where: { $0.trainNumber == trainNumber })
            status = .success
        } catch let error as TrainInfoAPI.TrainInfoAPIError {
            switch error {
            case .serviceSuspended:
                status = .isServiceSuspended
            default:
                status = .unknownError
            }
        } catch {
            status = .unknownError
        }
    }
}
