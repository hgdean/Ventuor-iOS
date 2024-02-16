//
//  PreferencesView.swift
//  Ventuor
//
//  Created by Sam Dean on 2/16/24.
//

import SwiftUI

struct PreferencesView: View {

    @Binding var selection: Metric

//    init(selection: Binding<Metric> = Binding(projectedValue: .constant(Metric.miles))) {
//        self._selection = selection
//    }
    
    var body: some View {
        NavigationStack() {
            VStack(spacing: 0) {
                Divider()
                    .padding(.top, 50)
                Button(action: {
                    setSelection(Metric.miles)
                }, label: {
                    HStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text(Metric.miles.rawValue)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .padding([.top, .bottom], 20)
                            .foregroundColor(.ventuorBlue)
                            .opacity(selection == Metric.miles ? 1 : 0)
                            .frame(width: 15)
                    }
                    .padding([.leading, .trailing], 20)
                    .border(width: 1, edges: [.bottom], color: .ventuorGray)
                })
                .background(Color(.white))
                
                Button(action: {
                    setSelection(Metric.kilometers)
                }, label: {
                    HStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text(Metric.kilometers.rawValue)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .padding([.top, .bottom], 20)
                            .foregroundColor(.ventuorBlue)
                            .opacity(selection == Metric.kilometers ? 1 : 0)
                            .frame(width: 15)
                    }
                    .padding([.leading, .trailing], 20)
                    .border(width: 1, edges: [.bottom], color: .ventuorGray)
                })
                .background(Color(.white))
            }
        }
        Spacer()
    }
    
    func setSelection(_ selection: Metric) {
        self.selection = selection
        SettingsInfo.distanceInKilometers = selection == Metric.kilometers
        SettingsInfo.distanceInMiles = selection == Metric.miles
    }
}

#Preview {
    PreferencesView(selection: Binding(projectedValue: .constant(Metric.miles)))
}
