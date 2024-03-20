//
//  VentuorPagesItem.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/16/24.
//

import SwiftUI


struct VentuorPagesItem: View {
    @State var showPagesSheet: Pages? = nil
    @State var pages: [PageVO]

    static var sample = PageVO(ventuorKey: "KHLKHDKHKC", pageId: "DGDYJDBHDBJ", title: "Special Message", detail: "<p>Hello</p>")
    static var samplePages: [PageVO] = [ PageVO(ventuorKey: "KHLKHDKHKC", pageId: "DGDYJDBHDBJ", title: "Special Message", detail: "<p>Hello</p>") ]
    
    var body: some View {
        ForEach(0..<pages.count, id: \.self) { index in
            Button(action: {
                self.showPagesSheet = Pages(id: index, page: pages[index])
            }, label: {
                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        let name = pages[index].title ?? ""
                        Text(name)
                            .foregroundColor(.ventuorBlue)
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
        .sheet(item: $showPagesSheet, content: { item in
            VentuorGenericSheet(title: (item.page?.title ?? ""),  html: item.page?.detail ?? "")
                .presentationDetents([.height(700), .medium, .large])
                .presentationDragIndicator(.automatic)
        })
    }
}

#Preview {
    VentuorPagesItem(pages: VentuorPagesItem.samplePages)
}
