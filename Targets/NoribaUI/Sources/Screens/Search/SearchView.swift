import SwiftUI

public struct SearchView: View {
    @ObservedObject private var viewModel: SearchViewModel
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case vehicleNumber
    }
    
    public init() {
        self.viewModel = SearchViewModel()
    }
    
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
    }
    
    private var vehicleTextField: some View {
        TextField("車両番号", text: $viewModel.vehicleNumber)
            .keyboardType(.numberPad)
            .focused($focusedField, equals: .vehicleNumber)
            .frame(maxWidth: .infinity, maxHeight: 24, alignment: .leading)
            .padding()
            .fontWeight(.bold)
            .background(Color("TextFieldColor"))
    }
    
    private var boundPickerView: some View {
        Menu {
            Picker(selection: $viewModel.currentBound,
                   label: EmptyView(),
                   content: {
                ForEach(viewModel.bounds) { bound in
                    Text(bound.title).tag(bound)
                }
            }).pickerStyle(.automatic)
                .accentColor(.white)
        } label: {
            Text(viewModel.currentBound.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Label"))
                .frame(maxWidth: .infinity, maxHeight: 24, alignment: .leading)
                .padding()
        }
        .background(Color("TextFieldColor"))
    }
    
    private var stationNameMenu: some View {
        Menu {
            Picker(selection: $viewModel.currentStation,
                   label: EmptyView(),
                   content: {
                ForEach(viewModel.stations) { station in
                    Text("\(station.stationName)駅").tag(station)
                }
            })
        } label: {
            Text("\(viewModel.currentStation.stationName)駅")
                .fontWeight(.bold)
                .foregroundColor(Color("Label"))
                .frame(maxWidth: .infinity, maxHeight: 24, alignment: .leading)
                .padding()
        }
        .background(Color("TextFieldColor"))
    }
    
    private var searchButton: some View {
        Button {
            viewModel.onSearchTapped()
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
                destination: VehicleResultView(trainNumber: viewModel.vehicleNumber,
                                               departureInfo: viewModel.departureInfo),
                isActive: $viewModel.isPresentVehicleResultView,
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
