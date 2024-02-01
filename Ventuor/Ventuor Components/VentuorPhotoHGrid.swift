//
//  ImagesGrid.swift
//  PhotoGalleryApp
//
//  Created by Sam Dean on 1/30/24.
//

import SwiftUI

class ImageSelection: ObservableObject {
    @Published var selectData: datamode? = nil
    @Published var selectedPhoto: PhotoItem? = nil
    @Published var showingSheet: Bool = false
    
    func getHeight(_ index: Int) -> CGFloat {
        return index % 2 == 0 ? 180 : 300
    }
    func getHeight2(_ index: Int) -> CGFloat {
        return index % 2 == 0 ? 300 : 180
    }
}

struct PhotoItem: Identifiable, Equatable {
    var id = UUID()
    var ventuorKey: String
    var liveMode: Bool
    var imageLocation: String
    var imageType: String
    var caption: String
    static func == (lhs:PhotoItem, rhs: PhotoItem) -> Bool {
        return lhs.id == rhs.id
    }
}
struct datamode: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var title: String
    static func == (lhs:datamode, rhs: datamode) -> Bool {
        return lhs.id == rhs.id
    }
}

struct VentuorPhotoHGrid: View {
    @State var photos: [ImageFileVO]
    @State var ventuor: VentuorData
    
    @ObservedObject var imageSelection = ImageSelection()
    
    let rows: [GridItem] = [GridItem(.adaptive(minimum: 50, maximum: 100)),
                            GridItem(.adaptive(minimum: 50, maximum: 100))]
    let rows2: [GridItem] = [GridItem(.fixed(100)),GridItem(.fixed(200))]
    let rows3: [GridItem] = [GridItem(.flexible())]
    let rows4: [GridItem] = [GridItem(.flexible(minimum: 100, maximum: 150)),
                             GridItem(.flexible(minimum: 100, maximum: 150))]
    let rows5: [GridItem] = [GridItem(.flexible()),
                             GridItem(.flexible())]
    let rows6: [GridItem] = [GridItem(.flexible(minimum: 100, maximum: 200))]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows6, spacing: 10) {
                ForEach(0..<ventuor.photos!.count, id: \.self) { index in
                    Button {
                        let ventuorKey = ventuor.ventuorKey ?? ""
                        let liveMode = ventuor.liveMode ?? true
                        let imageLocation = ventuor.photos?[index].fileName ?? ""
                        let imageType = ventuor.photos?[index].fileType ?? ""
                        let caption = ventuor.photos?[index].caption ?? ""
                        imageSelection.selectedPhoto = PhotoItem(ventuorKey: ventuorKey, liveMode: liveMode, imageLocation: imageLocation, imageType: imageType, caption: caption)
                        imageSelection.showingSheet = true
                    } label: {
                        let ventuorKey = ventuor.ventuorKey ?? ""
                        let liveMode = ventuor.liveMode ?? true
                        let imageLocation = ventuor.photos?[index].fileName ?? ""
                        let imageType = ventuor.photos?[index].fileType ?? ""
                        let caption = ventuor.photos?[index].caption ?? ""
                        RemotePhotoThumb(
                            ventuorKey: ventuorKey,
                            liveMode: liveMode,
                            imageLocation: imageLocation,
                            imageType: imageType,
                            placeholderImage: Image(systemName: "photo"),
                            photoDownloader: DefaultPhotoDownloader(ventuorKey: ventuorKey, liveMode: liveMode,
                                                                    imageLocation: imageLocation,
                                                                    imageType: imageType))
                    }
                    //.background(.yellow)
                }
            }
            //.background(.blue)
        }
        //.background(.green)
        //.frame(height: 350)
        .padding(.horizontal, 10)
        .sheet(isPresented: $imageSelection.showingSheet) {
            VentuorSelectedPhotoView(selectedPhoto: imageSelection.selectedPhoto!)
                .presentationDetents([.fraction(0.64), .large])
                .presentationDragIndicator(.visible)
        }
    }
}

func getHeight(_ index: Int) -> CGFloat {
    return index % 2 == 0 ? 175 : 175
}
func getHeight2(_ index: Int) -> CGFloat {
    return index % 2 == 0 ? 300 : 180
}

//#Preview {
//    VentuorPhotoHGrid()
//}
