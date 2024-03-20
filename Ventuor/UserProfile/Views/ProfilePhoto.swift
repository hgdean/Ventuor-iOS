//
//  ProfilePhoto.swift
//  Ventuor
//
//  Created by Sam Dean on 2/12/24.
//

import SwiftUI
import PhotosUI

struct ProfilePhoto: View {
    @EnvironmentObject var userProfileModel: UserProfileModel // Can only be used in a View

    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var uiImage: UIImage?
    @State private var selectedPhoto: UIImage?
    
    @State var showPicker: Bool = false
    @State var showDialog: Bool = false
    @State var showCamera: Bool = false
    
    var body: some View {
        ZStack {
            Button {
                showDialog.toggle()
            } label: {
                if self.uiImage != nil {
                    Image(uiImage: self.uiImage!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .overlay(Circle().stroke(Color.yellow, lineWidth: 5))
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(40)
                        .frame(width: 200, height: 200)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .overlay(Circle().stroke(Color.yellow, lineWidth: 5))
                        .opacity(0.6)
                }
            }
        }
        .onAppear() {
            createImage()
        }
        .padding()
        .errorAlert(error: $userProfileModel.error)
        .alert(item: $userProfileModel.message) { message in
            return Alert(
                title: Text(message.title),
                message: Text(message.message),
                dismissButton: .cancel()
            )
        }
        .confirmationDialog("Profile Picture", isPresented: $showDialog) {
            Button {
                showCamera.toggle()
            } label: {
                Label("Camera", systemImage: "camera")
            }
            Button {
                showPicker.toggle()
            } label: {
                Label("Gallery", systemImage: "photo.artframe")
            }
        }
        .photosPicker(isPresented: $showPicker, selection: $selectedItem)
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    saveImage(data: data)
                }
            }
        }
        .fullScreenCover(isPresented: self.$showCamera) {
            accessCameraView(selectedImage: self.$selectedPhoto)
        }
    }
    
    struct accessCameraView: UIViewControllerRepresentable {
        
        @Binding var selectedImage: UIImage?
        @Environment(\.presentationMode) var isPresented
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = context.coordinator
            return imagePicker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
            
        }

        func makeCoordinator() -> Coordinator {
            return Coordinator(picker: self)
        }
    }

    // Coordinator will help to preview the selected image in the View.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var picker: accessCameraView
        
        init(picker: accessCameraView) {
            self.picker = picker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else { return }
            self.picker.selectedImage = selectedImage
            self.picker.isPresented.wrappedValue.dismiss()
        }
    }
    
    func saveImage(data: Data) {
        uiImage = UIImage(data: data)
        
        if uiImage != nil {
            let imageData = uiImage!.jpegData(compressionQuality: 0.0)!
            let base64String = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) // encode the image
            userProfileModel.saveProfilePhoto(base64String: base64String)
        }
        else {
            print("Error selecting and converting selected image.")
        }
    }
    
    func createImage() {
        if userProfileModel.userProfileDataModel.profilePhoto != "" {
            let decodedData = Data(base64Encoded: (userProfileModel.userProfileDataModel.profilePhoto), options: Data.Base64DecodingOptions(rawValue: 0))
            uiImage = UIImage(data: decodedData!) ?? UIImage()
        }
    }
}

#Preview {
    ProfilePhoto()
        .environmentObject(UserProfileModel.shared)
}
