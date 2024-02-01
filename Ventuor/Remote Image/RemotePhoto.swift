//
//  RemotePhoto.swift
//  Ventuor
//
//  Created by Sam Dean on 1/29/24.
//

import SwiftUI

protocol PhotoDownloader {
    var cacheKey: String { get }
    func downloadPhotoData(completion: @escaping (Data?) -> Void)
}

class DefaultPhotoDownloader: PhotoDownloader {
    let ventuorKey: String
    let liveMode: Bool
    let imageLocation: String
    let imageType: String

    var cacheKey: String {
        ventuorKey
    }
    
    init(ventuorKey: String, liveMode: Bool, imageLocation: String, imageType: String) {
        self.ventuorKey = ventuorKey
        self.liveMode = liveMode
        self.imageLocation = imageLocation
        self.imageType = imageType
    }
    
    func downloadPhotoData(completion: @escaping (Data?) -> Void) {
        let services = Services(baseURL: API.baseURL + "/mobile/getMobileVentuorPhoto")
        services.getMobileVentuorPhoto(ventuorKey, liveMode: liveMode, imageLocation: imageLocation, imageType: imageType, 
                                       cb: { data, error in
            // print(String(data: data!, encoding: .utf8)!)
            do {
                let response = try JSONDecoder().decode(MobileGetVentuorPhotoResponseResult.self, from: data!)
                // print(response)
                
                if let imageString = response.result?.photo {
                    if !imageString.isEmpty {
                        //base64 string to NSData
                        let decodedData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions(rawValue: 0))
                        completion(decodedData)
                    }
                }
            } catch {
            }
        })
    }
}

class RemotePhotoCache: NSCache<NSString, UIImage> {
    static let shared = RemotePhotoCache()
    
    func cache(_ image: UIImage, for key: String) {
        self.setObject(image, forKey: key as NSString)
    }
    
    func getImage(for key: String) -> UIImage? {
        self.object(forKey: key as NSString)
    }
}

struct RemotePhotoThumb: View {
    
    @State var uiImage: UIImage?

    let ventuorKey: String
    let liveMode: Bool
    let imageLocation: String
    let imageType: String
    
    let placeholderImage: Image
    let photoDownloader: PhotoDownloader
    
    init(ventuorKey: String, liveMode: Bool, imageLocation: String, imageType: String, placeholderImage: Image, photoDownloader: PhotoDownloader) {
        self.ventuorKey = ventuorKey
        self.liveMode = liveMode
        self.imageLocation = imageLocation
        self.imageType = imageType
        self.placeholderImage = placeholderImage
        self.photoDownloader = photoDownloader
    }
    
    var body: some View {
        if let uiImage = self.uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 175)
                .cornerRadius(20)
                .padding(.vertical, 2)
        } else {
            placeholderImage
                .resizable()
                .scaledToFill()
                .frame(height: 175)
                .cornerRadius(20)
                .padding(.vertical, 2)
                .onAppear(perform: getImage)
        }
    }
    
    private func getImage() {
        let cacheKey = photoDownloader.cacheKey
        if let cachedImage = RemotePhotoCache.shared.getImage(for: cacheKey) {
            print("using cached photo")
            self.uiImage = cachedImage
        } else {
            print("Downloading photo")
            photoDownloader.downloadPhotoData { imageData in
                guard
                    let imageData = imageData,
                    let uiImage = UIImage(data: imageData)
                else {
                    self.uiImage = nil
                    return
                }

                RemotePhotoCache.shared.cache(uiImage, for: cacheKey)

                DispatchQueue.main.async {
                    self.uiImage = uiImage
                }
            }
        }
    }
}

struct RemotePhoto: View {
    
    @State var uiImage: UIImage?

    let ventuorKey: String
    let liveMode: Bool
    let imageLocation: String
    let imageType: String
    
    let placeholderImage: Image
    let photoDownloader: PhotoDownloader
    
    init(ventuorKey: String, liveMode: Bool, imageLocation: String, imageType: String, placeholderImage: Image, photoDownloader: PhotoDownloader) {
        self.ventuorKey = ventuorKey
        self.liveMode = liveMode
        self.imageLocation = imageLocation
        self.imageType = imageType
        self.placeholderImage = placeholderImage
        self.photoDownloader = photoDownloader
    }
    
    var body: some View {
        if let uiImage = self.uiImage {
            Image(uiImage: uiImage)
                .resizable().scaledToFill()
                .frame(maxWidth: UIScreen.main.bounds.width)
                .frame(height: 300)
                .clipped()
        } else {
            placeholderImage
                .resizable().scaledToFill()
                .frame(maxWidth: UIScreen.main.bounds.width)
                .frame(height: 300)
                .clipped()
                .onAppear(perform: getImage)
        }
    }
    
    private func getImage() {
        let cacheKey = photoDownloader.cacheKey
        if let cachedImage = RemotePhotoCache.shared.getImage(for: cacheKey) {
            print("using cached photo")
            self.uiImage = cachedImage
        } else {
            print("Downloading photo")
            photoDownloader.downloadPhotoData { imageData in
                guard
                    let imageData = imageData,
                    let uiImage = UIImage(data: imageData)
                else {
                    self.uiImage = nil
                    return
                }

                RemotePhotoCache.shared.cache(uiImage, for: cacheKey)

                DispatchQueue.main.async {
                    self.uiImage = uiImage
                }
            }
        }
    }
}
