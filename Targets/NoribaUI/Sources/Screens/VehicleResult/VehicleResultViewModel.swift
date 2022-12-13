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
    
    func onAppear() async
    func unixtimeToDate(unixtime: Int) -> String
}

public class VehicleResultViewModel: VehicleResultViewModelInput, ObservableObject {
    public let trainNumber: String
    public let bound: Bound
    public let station: DepartureInfo.DepartureInfo.Data.Station
    
    @Published private(set) public var status: VehicleResultViewStatus = .isLoading
    @Published private(set) public var departureInfo: DepartureInfo? = nil
    @Published private(set) public var resultTrainData: DepartureInfo.DepartureInfo.Data? = nil
    
    public init(trainNumber: String, bound: Bound, station: DepartureInfo.DepartureInfo.Data.Station) {
        self.trainNumber = trainNumber
        self.bound = bound
        self.station = station
    }
    
    // MARK: VehicleResultViewModelInput
    public func onAppear() async {
         await fetch()
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
