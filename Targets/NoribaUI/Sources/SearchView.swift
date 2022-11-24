import SwiftUI
import NoribaKit

public struct SearchView: View {
    @State private var vehicleNumber = ""
    @FocusState private var focusedField: Field?
    @State private var bound: Bound = .hakata
    @State private var isPresentVehicleResultView = false
    @State private var departureInfo: DepartureInfo? = nil
    
    enum Bound: String, CaseIterable, Identifiable {
        case hakata = "hakata"
        case tokyo = "tokyo"
        
        var id: String { rawValue }
        
        var title: String {
            switch self {
            case .hakata:
                return "博多方面（下り）"
            case .tokyo:
                return "東京方面（のぼり）"
            }
        }
    }
    enum Field: Hashable {
        case vehicleNumber
    }
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 24) {
            Spacer()
                .frame(height: 18)
            
            vehicleTextField
            stationNameMenu
            boundPickerView
            searchButton
            Spacer()
        }
        .padding()
        .onTapGesture {
            focusedField = nil
        }
        .navigationTitle("のりば検索")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            departureInfo = try! await TrainInfoAPI().fetchDepartureInfo()
        }
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
    
    private var boundPickerView: some View {
        Menu {
            Picker(selection: $bound,
                label: EmptyView(),
                content: {
                ForEach(Bound.allCases) { bound in
                    Text(bound.title).tag(bound)
                }
                }).pickerStyle(.automatic)
                   .accentColor(.white)
            } label: {
                Text(bound.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Label"))
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
                .foregroundColor(Color("Label"))
                .frame(maxWidth: .infinity, maxHeight: 24, alignment: .leading)
                .padding()
        }
        .background(Color("TextFieldColor"))
    }
    
    private var searchButton: some View {
        Button {
            isPresentVehicleResultView = true
        } label: {
            Text("検索")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 24)
                .padding()
                .background(Color.pink.cornerRadius(8))
        }
        .background(
            NavigationLink(
                destination: VehicleResultView(trainNumber: vehicleNumber, departureInfo: departureInfo),
                isActive: $isPresentVehicleResultView,
                label: { EmptyView() })
        )
        
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
#endif
