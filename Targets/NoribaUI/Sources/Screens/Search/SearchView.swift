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
            stationNamePickerMenu
            boundPickerMenu
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
        TextField("列車番号", text: $viewModel.vehicleNumber)
            .keyboardType(.numberPad)
            .focused($focusedField, equals: .vehicleNumber)
            .frame(maxWidth: .infinity, maxHeight: 24, alignment: .leading)
            .padding()
            .fontWeight(.bold)
            .background(Color("TextFieldColor"))
    }
    
    private var boundPickerMenu: some View {
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
    
    private var stationNamePickerMenu: some View {
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
        NavigationLink(value: VehicleResultNavigation(trainNumber: viewModel.vehicleNumber,
                                                      bound: viewModel.currentBound,
                                                      station: viewModel.currentStation),
                       label: {
            Text("検索")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 24)
                .padding()
                .background(Color.pink.cornerRadius(8))
        })
    }
}

#if DEBUG
private struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
#endif
