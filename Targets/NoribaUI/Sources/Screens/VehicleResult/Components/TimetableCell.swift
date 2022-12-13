//
//  TimetableCell.swift
//  Noriba
//
//  Created by a on 12/14/22.
//

import SwiftUI

struct TimetableCell: View {
    let trainName: String
    let trainNumber: String
    let stationName: String
    let trackNumber: Int
    let departureTime: Int
    let trainColor: Color
    
    var body: some View {
        HStack {
            VStack {
                Text("\(trainName)")
                    .font(.system(size: 16, weight: .bold))
                Text(trainNumber)
                    .font(.system(size: 13, weight: .bold))
            }
            .frame(width: 72, height: 50, alignment: .center)
            .background(trainColor.cornerRadius(8))
            
            Text(getDatetime())
                .font(.system(size: 15, weight: .bold))
                .frame(width: 72, height: 50, alignment: .center)

            Text("\(stationName)")
                .font(.system(size: 15, weight: .bold))

            Spacer()
            Text("\(trackNumber)")
                .font(.system(size: 17, weight: .bold))
                .padding(6)
                .foregroundColor(.black)
                .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
    
    func getDatetime() -> String {
        "\(String(departureTime / 60).leftPadding(toLength: 2, withPad: "0")):\(String(departureTime % 60).leftPadding(toLength: 2, withPad: "0"))"
    }
}

struct TimetableCellPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                TimetableCell(trainName: "のぞみ", trainNumber: "123", stationName: "新大阪", trackNumber: 13, departureTime: 540, trainColor: .red)
                TimetableCell(trainName: "のぞみ", trainNumber: "123", stationName: "新大阪", trackNumber: 13, departureTime: 540, trainColor: .blue)
                TimetableCell(trainName: "のぞみ", trainNumber: "123", stationName: "新大阪", trackNumber: 13, departureTime: 540, trainColor: .yellow)
                TimetableCell(trainName: "のぞみ", trainNumber: "123", stationName: "新大阪", trackNumber: 13, departureTime: 540, trainColor: .red)
                TimetableCell(trainName: "のぞみ", trainNumber: "123", stationName: "新大阪", trackNumber: 13, departureTime: 540, trainColor: .red)
            }
        }
    }
}
