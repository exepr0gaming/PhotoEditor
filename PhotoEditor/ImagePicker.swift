//
//  ImagePicker.swift
//  PhotoEditor
//
//  Created by Andrew Kurdin on 30.07.2023.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  
  @Binding var showPicker: Bool
  @Binding var imageData: Data
  
  func makeCoordinator() -> Coordinator {
    return ImagePicker.Coordinator(parent: self)
  }
  func makeUIViewController(context: Context) -> some UIViewController {
    let controller = UIImagePickerController()
    controller.sourceType = .photoLibrary
    controller.delegate = context.coordinator
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    //
  }
  
  class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // getting Parent view context to update image Data
    var parent: ImagePicker
    init(parent: ImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      // gettings image and closing
      if let imageData = (info[.originalImage] as? UIImage)?.pngData() {
        parent.imageData = imageData
        parent.showPicker.toggle()
      }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      // closing view if cancelled
      parent.showPicker.toggle()
    }
  }
}

//struct ImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePicker()
//    }
//}
