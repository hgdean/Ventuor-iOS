//
//  VentuorDeptHoursItem.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/15/24.
//

import SwiftUI

struct VentuorDeptHoursItem: View {
    @State var showDeptHoursSheet: DepartmentHours? = nil
    @State var departmentHours: [DepartmentHoursJSON]
    
    var body: some View {
        ForEach(0..<departmentHours.count, id: \.self) { index in
            Button(action: {
                self.showDeptHoursSheet = DepartmentHours(id: index, deptHours: departmentHours[index])
            }, label: {
                HStack(spacing: 20) {
                    Image("open")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    VStack(alignment: .leading) {
                        let name = departmentHours[index].name ?? ""
                        Text(name + " Hours")
                        Text(departmentHours[index].statusMessage ?? "")
                            .fontWeight(.medium)
                            .font(.caption)
                            .foregroundColor(departmentHours[index].status == "open" ? .ventuorOpenGreen : .ventuorClosedRed)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right.circle")
                        .resizable()
                        .scaledToFit()
                        .padding([.top, .bottom], 20)
                        .foregroundColor(.ventuorBlue)
                        .opacity(0.3)
                        .frame(width: 20)
                }
                .padding([.leading, .trailing], 15)
                .border(width: 1, edges: [.bottom], color: .ventuorGray)
            })
        }
        .sheet(item: $showDeptHoursSheet, content: { item in
            VentuorHoursSheet(title: (item.deptHours?.name ?? "") + " Hours",  hoursHtml: item.deptHours?.content ?? "")
                .presentationDetents([.height(500), .medium, .large])
                .presentationDragIndicator(.automatic)
        })
    }
}

//#Preview {
//    VentuorDeptHoursItem(departmentHoursCount: 1, departmentHours: <#DepartmentHoursJSON#>)
//}
