//
//  RemoteImage.swift
//  Ventuor
//
//  Created by Sam Dean on 1/29/24.
//

import SwiftUI

protocol LogoImageDownloader {
    var cacheKey: String { get }
    func downloadLogoImageData(completion: @escaping (Data?) -> Void)
}

class DefaultLogoImageDownloader: LogoImageDownloader {
    @State var ventuorKey: String
    @State var liveMode: Bool
    
    var cacheKey: String {
        ventuorKey
    }
    
    init(ventuorKey: String, liveMode: Bool) {
        self.ventuorKey = ventuorKey
        self.liveMode = liveMode
    }
    
    func downloadLogoImageData(completion: @escaping (Data?) -> Void) {
        let services = Services(baseURL: API.baseURL + "/mobile/getVentuorLogoByVentuorKey")
        services.getVentuorLogoByVentuorKey(ventuorKey, liveMode: liveMode, cb: { data, error in
            if let data = data {
                //print(String(data: data, encoding: .utf8)!)
                do {
                    let response = try JSONDecoder().decode(GetVentuorLogoResponseResult.self, from: data)
                    //print(response)
                    
                    if let imageString = response.result?.image {
                        if !imageString.isEmpty {
                            let idString = response.result?.id
                            assert(idString != nil && idString!.isEmpty == false, "Unexpected. Should have an id if we have an image!!")
                            
                            //base64 string to NSData
                            let decodedData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions(rawValue: 0))
                            completion(decodedData)
                        }
                    }
                } catch {
                    print("Could not decode GetVentuorLogoResponseResult: \(error)")
                }
            }
        })
    }
}

class RemoteLogoImageCache: NSCache<NSString, UIImage> {
    static let shared = RemoteLogoImageCache()
    
    func cache(_ image: UIImage, for key: String) {
        self.setObject(image, forKey: key as NSString)
    }
    
    func getImage(for key: String) -> UIImage? {
        self.object(forKey: key as NSString)
    }
}

struct RemoteLogoImage: View {
    
    @State var uiImage: UIImage?

    let ventuorKey: String
    let liveMode: Bool
    let placeholderImage: Image
    let logoImageDownloader: LogoImageDownloader
    
    init(ventuorKey: String, liveMode: Bool, placeholderImage: Image, logoImageDownloader: LogoImageDownloader) {
        self.ventuorKey = ventuorKey
        self.liveMode = liveMode
        self.placeholderImage = placeholderImage
        self.logoImageDownloader = logoImageDownloader
    }
    
    var body: some View {
        if let uiImage = self.uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .onAppear(perform: getImage)
        } else {
            placeholderImage
                .resizable()
                .onAppear(perform: getImage)
        }
    }
    
    private func getImage() {
        let cacheKey = logoImageDownloader.cacheKey
        if let cachedImage = RemoteLogoImageCache.shared.getImage(for: cacheKey) {
            print("using cached image")
            self.uiImage = cachedImage
        } else {
            print("Downloading image")
            logoImageDownloader.downloadLogoImageData { imageData in
                guard
                    let imageData = imageData,
                    let uiImage = UIImage(data: imageData)
                else {
                    self.uiImage = nil
                    return
                }
                
                RemoteLogoImageCache.shared.cache(uiImage, for: cacheKey)
                
                DispatchQueue.main.async {
                    self.uiImage = uiImage
                }
            }
        }
    }
}
