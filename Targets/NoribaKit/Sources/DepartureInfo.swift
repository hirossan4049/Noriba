//
//  DepartureInfo.swift
//  NoribaKit
//
//  Created by a on 11/23/22.
//

import Foundation

struct DepartureInfo: Codable {
    let suspensionInfoIsEnabled: Bool
    let departureInfo: DepartureInfo
    
    struct DepartureInfo: Codable {
        let datetime: Int
        let data: [Data]
        
        struct Data: Codable {
            let train: Train
            let trainNumber: String
            let departureTime: Int
            let undecidedTimeFlag: Bool
            let expactation: Int?
            let delay: [Int]
            let track: Int // のりば x番線
            let terminalStation: String
            let stations: [Station]
            let startingStationFlag: Bool
            let departureFlag: Bool
//            let remark:
            let alternativeTrain: String
            let alternativeTrainNumber: String
//            let stopInfo
            let departureOrder: Int
            let partialSuspensionFlag: Bool
            
            enum Train: String, Codable {
                case hikari = "1"
                case kodama = "2"
                case nozomi = "6"
                case dantai = "8"
                case kaisou = "9"
                case mizuho = "10"
                case sakura = "11"
                case tubame = "12"
                case unknown = "255"
                
                var jaName: String {
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
            
            enum Station: String, Codable {
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
            }
        }
    }
}
