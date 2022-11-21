import SwiftUI

public struct SearchView: View {
    @State private var vehicleNumber = ""
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case vehicleNumber
    }
    
    public init() {}

    public var body: some View {
        VStack(spacing: 24) {
            Spacer()
                .frame(height: 18)
            
            vehicleTextField
            vehicleTypeMenu
            stationNameMenu
            searchButton
            Spacer()
        }
        .padding()
        .onTapGesture {
            focusedField = nil
        }
        .navigationTitle("のりば検索")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var vehicleTextField: some View {
        TextField("車両番号", text: $vehicleNumber)
            .keyboardType(.numberPad)
            .focused($focusedField, equals: .vehicleNumber)
            .frame(maxWidth: .infinity, maxHeight: 24, alignment: .leading)
            .padding()
            .fontWeight(.bold)
            .background(Color("TextFieldColor"))
    }
    
    private var vehicleTypeMenu: some View {
        Menu {
            Button("ひかり", action: {})
            Button("こだま", action: {})
            Button("のぞみ", action: {})
            Button("団体", action: {})
            Button("回送", action: {})
            Button("みずほ", action: {})
            Button("さくら", action: {})
            Button("つばめ", action: {})
            Button("未設定", action: {})
        } label: {
            Text("のぞみ")
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: 24, alignment: .leading)
                .padding()
        }
        .background(Color("TextFieldColor"))
    }
    
    private var stationNameMenu: some View {
        Menu {
            Button("新大阪", action: {})
            Button("京都", action: {})
            Button("新横浜", action: {})
            Button("品川", action: {})
            Button("東京", action: {})
        } label: {
            Text("新大阪")
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: 24, alignment: .leading)
                .padding()
        }
        .background(Color("TextFieldColor"))
    }
    
    private var searchButton: some View {
        Button {
            
        } label: {
            Text("検索")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 24)
                .padding()
                .background(Color.pink.cornerRadius(8))
        }

    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
#endif
