//
//  DepartureInfo.swift
//  NoribaKit
//
//  Created by a on 11/23/22.
//

import Foundation

public struct DepartureInfo: Codable, Hashable {
    public let suspensionInfoIsEnabled: Bool
    public let departureInfo: DepartureInfo
    
    public struct DepartureInfo: Codable, Hashable {
        public let datetime: Int
        public let data: [Data]
        
        public struct Data: Codable, Hashable {
            public let train: Train
            public let trainNumber: String
            public let departureTime: Int
            public let undecidedTimeFlag: Bool
            public let expactation: Int?
            public let delay: [Int]
            public let track: Int // のりば x番線
            public let terminalStation: Station
            public let stations: [Station]
            public let startingStationFlag: Bool
            public let departureFlag: Bool
            //          public   let remark:
            public let alternativeTrain: String
            public let alternativeTrainNumber: String
            //          public   let stopInfo
            public let departureOrder: Int
            public let partialSuspensionFlag: Bool
            
            public enum Train: String, Codable, Hashable {
                case hikari = "1"
                case kodama = "2"
                case nozomi = "6"
                case dantai = "8"
                case kaisou = "9"
                case mizuho = "10"
                case sakura = "11"
                case tubame = "12"
                case unknown = "255"
                
                public var jaName: String {
                    switch self {
                    case .hikari:
                        return "ひかり"
                    case .kodama:
                        return "こだま"
                    case .nozomi:
                        return "のぞみ"
                    case .dantai:
                        return "団体"
                    case .kaisou:
                        return "回送"
                    case .mizuho:
                        return "みずほ"
                    case .sakura:
                        return "さくら"
                    case .tubame:
                        return "つばめ"
                    case .unknown:
                        return "未設定"
                    }
                }
            }
            
            public enum Station: String, Codable, CaseIterable {
                case tokyo = "1"
                case shinagawa = "2"
                case shinyokohama = "3"
                case odawara = "4"
                case atami = "5"
                case mishima = "6"
                case shinfuji = "32"
                case shizuoka = "7"
                case kakegawa = "33"
                case hamamatsu = "8"
                case toyohashi = "9"
                case mikawaanjo = "34"
                case nagoya = "10"
                case gifuhashima = "11"
                case maibara = "12"
                case kyoto = "13"
                case shinosaka = "15"
                case shinkobe = "16"
                case nishiakashi = "17"
                case himeji = "18"
                case aisho = "19"
                case okayama = "20"
                case shinkurashiki = "21"
                case hukuyama = "22"
                case shinomichi = "35"
                case mihara = "23"
                case higashihiroshima = "41"
                case hiroshima = "24"
                case shiniwakoku = "25"
                case tokuyama = "26"
                case shinyamaguchi = "27"
                case asa = "42"
                case shinshimonoseki = "28"
                case ogura = "29"
                case hakata = "30"
                case shintosu = "46"
                case kurume = "47"
                case chikugofunagawa = "48"
                case shinomuta = "49"
                case shintanama = "50"
                case kumamoto = "51"
                case shinyatsushiro = "52"
                case shinmizumata = "53"
                case izumi = "54"
                case sendai = "55"
                case kagoshimachuo = "56"
                
                public var stationName: String {
                    switch self {
                    case .tokyo:
                        return "東京"
                    case .shinagawa:
                        return "品川"
                    case .shinyokohama:
                        return "新横浜"
                    case .odawara:
                        return "小田原"
                    case .atami:
                        return "熱海"
                    case .mishima:
                        return "三島"
                    case .shinfuji:
                        return "新富士"
                    case .shizuoka:
                        return "静岡"
                    case .kakegawa:
                        return "掛川"
                    case .hamamatsu:
                        return "浜松"
                    case .toyohashi:
                        return "豊橋"
                    case .mikawaanjo:
                        return "三河安城"
                    case .nagoya:
                        return "名古屋"
                    case .gifuhashima:
                        return "岐阜羽島"
                    case .maibara:
                        return "米原"
                    case .kyoto:
                        return "京都"
                    case .shinosaka:
                        return "新大阪"
                    case .shinkobe:
                        return "新神戸"
                    case .nishiakashi:
                        return "西明石"
                    case .himeji:
                        return "姫路"
                    case .aisho:
                        return "相生"
                    case .okayama:
                        return "岡山"
                    case .shinkurashiki:
                        return "新倉敷"
                    case .hukuyama:
                        return "福山"
                    case .shinomichi:
                        return "新尾道"
                    case .mihara:
                        return "三原"
                    case .higashihiroshima:
                        return "東広島"
                    case .hiroshima:
                        return "広島"
                    case .shiniwakoku:
                        return "新岩国"
                    case .tokuyama:
                        return "徳山"
                    case .shinyamaguchi:
                        return "新山口"
                    case .asa:
                        return "厚狭"
                    case .shinshimonoseki:
                        return "新下関"
                    case .ogura:
                        return "小倉"
                    case .hakata:
                        return "博多"
                    case .shintosu:
                        return "新鳥栖"
                    case .kurume:
                        return "久留米"
                    case .chikugofunagawa:
                        return "筑後船小屋"
                    case .shinomuta:
                        return "新大牟田"
                    case .shintanama:
                        return "新玉名"
                    case .kumamoto:
                        return "熊本"
                    case .shinyatsushiro:
                        return "新八代"
                    case .shinmizumata:
                        return "新水俣"
                    case .izumi:
                        return "出水"
                    case .sendai:
                        return "川内"
                    case .kagoshimachuo:
                        return "鹿児島中央"
                    }
                }
                
                public static var sortedMajorStations: [Self] {
                    var stations = Self.allCases
                    for (i, st) in [Self.tokyo, .shinosaka, .nagoya, .kyoto, .shinagawa].enumerated() {
                        if let station = stations.firstIndex(where: {$0 == st}) {
                            stations.swapAt(station, i)
                        }
                    }
                    return stations
                }
            }
        }
    }
}
