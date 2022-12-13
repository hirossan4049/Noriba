//
//  VehicleResultView.swift
//  NoribaUI
//
//  Created by a on 11/22/22.
//

import SwiftUI
// FIXME: NoribaKitに依存しないようにする
import NoribaKit

public struct VehicleResultView: View {
    @StateObject var viewModel: VehicleResultViewModel
    
    public init(trainNumber: String, bound: Bound, station: DepartureInfo.DepartureInfo.Data.Station) {
        _viewModel = StateObject(wrappedValue: VehicleResultViewModel(trainNumber: trainNumber,
                                                                      bound: bound,
                                                                      station: station))
    }
    
    public var body: some View {
        VStack {
            Spacer()
                .frame(height: 24)
            ticket
                .padding(.horizontal, 8)
            annotationLabel
            
            if let departureInfo = viewModel.departureInfo {
                List(departureInfo.departureInfo.data, id: \.self) { data in
                    TimetableCell(trainName: data.train.jaName,
                                  trainNumber: data.trainNumber,
                                  stationName: data.terminalStation.stationName,
                                  trackNumber: data.track,
                                  departureTime: data.departureTime,
                                  trainColor: data.train.color)
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            } else {
                switch viewModel.status {
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
            await viewModel.onAppear()
        }
    }
    
    private var ticket: some View {
        ZStack {
            Image("ticketImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 164)
            
            if let resultTrainData = viewModel.resultTrainData {
                VStack {
                    Spacer()
                    Text("\(resultTrainData.train.jaName)\(resultTrainData.trainNumber)号 \(resultTrainData.terminalStation.stationName)行")
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                    
                    Text("\(viewModel.station.stationName)駅")
                        .font(.system(size: 18, weight: .bold))
                    
                    HStack {
                        Text("\(resultTrainData.track)番線")
                            .font(.system(size: 34, weight: .bold))
                        Text("※")
                            .font(.system(size: 20))
                            .frame(height: 30,alignment: .bottom)
                    }
                    
                    Text(viewModel.unixtimeToDate(unixtime: viewModel.departureInfo?.departureInfo.datetime ?? 0))
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
