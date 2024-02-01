//
//  VentuorSelectedPhotoView.swift
//  Ventuor
//
//  Created by Sam Dean on 1/31/24.
//

import SwiftUI

struct VentuorSelectedPhotoView: View {
    //var selectedData: datamode
    var selectedPhoto: PhotoItem

    var body: some View {
        VStack(spacing: 5) {
            RemotePhoto(
                ventuorKey: selectedPhoto.ventuorKey,
                liveMode: selectedPhoto.liveMode,
                imageLocation: selectedPhoto.imageLocation,
                imageType: selectedPhoto.imageType,
                placeholderImage: Image(systemName: "photo"),
                photoDownloader: DefaultPhotoDownloader(ventuorKey: selectedPhoto.ventuorKey, 
                                                        liveMode: selectedPhoto.liveMode,
                                                        imageLocation: selectedPhoto.imageLocation,
                                                        imageType: selectedPhoto.imageType))
//            Image(selectedData.name)
//                .resizable().scaledToFill()
//                .frame(maxWidth: UIScreen.main.bounds.width)
//                .frame(height: 300)
//                .clipped()
            VStack(alignment: .leading, spacing: 7) {
                Text(selectedPhoto.caption)
                    .font(.headline)
                    .frame(height: 130)
                    .frame(maxWidth: UIScreen.main.bounds.width)
                    .padding(10)
                    .background(.white).cornerRadius(10)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            }
            .padding(.horizontal)
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    VentuorSelectedPhotoView(selectedPhoto: PhotoItem(ventuorKey: "ventuorKey", liveMode: true, imageLocation: "imageLocation", imageType: "imageType", caption: "caption"))
}
