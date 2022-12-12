//
//  VehicleResultView.swift
//  NoribaUI
//
//  Created by a on 11/22/22.
//

import SwiftUI
import NoribaKit

public struct VehicleResultView: View {
    
    private let trainNumber: String
    private let bound: Bound
    private let station: DepartureInfo.DepartureInfo.Data.Station
    @State private var departureInfo: DepartureInfo? = nil
    @State private var resultTrainData: DepartureInfo.DepartureInfo.Data? = nil
    @State private var status: Status = .isLoading
    
    enum Status {
        case success
        case isLoading
        case isServiceSuspended
        case unknownError
    }
    
    public init(trainNumber: String, bound: Bound, station: DepartureInfo.DepartureInfo.Data.Station) {
        self.trainNumber = trainNumber
        self.bound = bound
        self.station = station
    }
    
    public var body: some View {
        VStack {
            Spacer()
                .frame(height: 24)
            ticket
                .padding(.horizontal, 8)
            annotationLabel
            
            if let departureInfo {
                List(departureInfo.departureInfo.data, id: \.self) { data in
                    timetableCell(data: data)
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            } else {
                switch status {
                case .success:
                    Text("Oops.\nアプリのエラー")
                        .padding()
                        .foregroundColor(.gray)
                case .isLoading:
                    ProgressView()
                case .isServiceSuspended:
                    Text("現在サービス一時停止中")
                        .padding()
                        .foregroundColor(.gray)
                case .unknownError:
                    Text("Oops.\nインターネットに接続されていないか、サーバーが落ちている可能性があります。")
                        .padding()
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
        .navigationTitle("新幹線のりば検索結果")
        .task {
            await fetch()
        }
    }
    
    private var ticket: some View {
        ZStack {
            Image("ticketImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 164)
            
            if let resultTrainData {
                VStack {
                    Spacer()
                    Text("\(resultTrainData.train.jaName)\(resultTrainData.trainNumber)号 \(resultTrainData.terminalStation.stationName)行")
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                    
                    Text("\(station.stationName)駅")
                        .font(.system(size: 18, weight: .bold))
                    
                    HStack {
                        Text("\(resultTrainData.track)番線")
                            .font(.system(size: 34, weight: .bold))
                        Text("※")
                            .font(.system(size: 20))
                            .frame(height: 30,alignment: .bottom)
                    }
                    
                    Text(unixtimeToDate(unixtime: departureInfo?.departureInfo.datetime ?? 0))
                        .font(.system(size: 14, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(8)
            } else {
                Text("存在しません")
                    .font(.system(size: 18, weight: .bold))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 164)
    }
    
    private var annotationLabel: some View {
        Text("※JR東海の公開情報に基づいて算出されています。実際ののりばと異なる場合がございます。")
            .font(.system(size: 9, weight: .bold))
            .foregroundColor(.gray)
    }
    
    func timetableCell(data: DepartureInfo.DepartureInfo.Data) -> some View {
        return HStack {
            Text("\(data.train.jaName) \(data.trainNumber)号")
                .frame(width: 100, alignment: .leading)
            Text("\(data.terminalStation.stationName)行")
            Spacer()
            Text("\(data.track)番線")
            Text("\(String(data.departureTime / 60).leftPadding(toLength: 2, withPad: "0")):\(String(data.departureTime % 60).leftPadding(toLength: 2, withPad: "0"))")
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: 48)
        .background(data.train.color.cornerRadius(8))
    }
    
    func unixtimeToDate(unixtime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixtime))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter.string(from: date)
    }
    
    func fetch() async {
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
    
    func getTrainNumberToData(trainNumber: String, departureInfo info: DepartureInfo?) -> DepartureInfo.DepartureInfo.Data? {
        info?.departureInfo.data.first(where: { $0.trainNumber == trainNumber })
    }
}

extension DepartureInfo.DepartureInfo.Data.Train {
    public var color: Color {
        switch self {
        case .hikari:
            return .red
        case .kodama:
            return .blue
        case .nozomi:
            return .yellow
        case .dantai:
            return .gray
        case .kaisou:
            return .gray
        case .mizuho:
            return .blue
        case .sakura:
            return .pink
        case .tubame:
            return .pink
        case .unknown:
            return .gray
        }
    }
}

extension String {
    func leftPadding(toLength: Int, withPad: String) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeating:withPad, count: toLength - stringLength) + self
        } else {
            return String(self.suffix(toLength))
        }
    }
}

//#if DEBUG
//struct VehicleResultView_Previews: PreviewProvider {
//    @State private static var departureInfo: DepartureInfo? = nil
//
//    static var previews: some View {
//        if let departureInfo = departureInfo {
//            return VehicleResultView(trainNumber: "247", departureInfo: departureInfo)
//        } else {
//            return Text("Parse Error")
//        }
//    }
//}
//#endif
