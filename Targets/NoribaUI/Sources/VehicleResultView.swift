//
//  VehicleResultView.swift
//  NoribaUI
//
//  Created by a on 11/22/22.
//

import SwiftUI

struct VehicleResultView: View {
    
    public init() {}
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 24)
            ticket
                .padding(.horizontal, 8)
            annotationLabel
            Spacer()
        }
        .navigationTitle("新幹線のりば検索結果")
    }
    
    private var ticket: some View {
        ZStack {
            Image("ticketImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 164)

            VStack {
                Spacer()
                Text("のぞみ235号 東京行")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                
                Text("新大阪駅")
                    .font(.system(size: 18, weight: .bold))
                
                HStack {
                    Text("24番線")
                        .font(.system(size: 34, weight: .bold))
                    Text("※")
                        .font(.system(size: 20))
                        .frame(height: 30,alignment: .bottom)
                }
                
                Text("2022年11月23日")
                    .font(.system(size: 14, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity, maxHeight: 164)
    }
    
    private var annotationLabel: some View {
        Text("※JR東海の公開情報に基づいて算出されています。実際ののりばと異なる場合がございます。")
            .font(.system(size: 9, weight: .bold))
            .foregroundColor(.gray)
    }
}

#if DEBUG
struct VehicleResultView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleResultView()
    }
}
#endif
