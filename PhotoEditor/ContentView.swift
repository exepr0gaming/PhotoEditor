//
//  ContentView.swift
//  PhotoEditor
//
//  Created by Andrew Kurdin on 30.07.2023.
//

import SwiftUI
import CropViewController
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
  @State private var photosPickerPresented = false
  @State private var photoPickerItems = [PhotosPickerItem]()
  
  @State private var image: Image?
  
  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
      
      Text("qweqwe")
      
      Button {
        photosPickerPresented.toggle()
      } label: {
        Text("Show Photos Picker")
      }
      .photosPicker(isPresented: $photosPickerPresented, selection: $photoPickerItems)
    }
    .onAppear(perform: loadImage)
  }
  
  private func loadImage() {
    guard let assetImage = UIImage(named: "profile") else { return }
    let beginImage = CIImage(image: assetImage)
    
    let context = CIContext()
    //let currentFilter = CIFilter.sepiaTone()
//    currentFilter.inputImage = beginImage
//    currentFilter.intensity = 1
     
//    let currentFilter = CIFilter.pixellate()
//    currentFilter.inputImage = beginImage
//    currentFilter.scale = 100
    
//    let currentFilter = CIFilter.crystallize()
//    currentFilter.inputImage = beginImage
//    currentFilter.radius = 200
    
//    currentFilter.radius = 1000
//    currentFilter.center = CGPoint(x: assetImage.size.width / 2, y: assetImage.size.height / 2)
    
    let currentFilter = CIFilter.twirlDistortion()
    currentFilter.inputImage = beginImage
    
    let amount = 1.0
    let inputKeys = currentFilter.inputKeys
    
    if inputKeys.contains(kCIInputIntensityKey) {
      currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
    }
    
    if inputKeys.contains(kCIInputRadiusKey) {
      currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
    }
    
    if inputKeys.contains(kCIInputScaleKey) {
      currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
    }
    
    guard let outputImage = currentFilter.outputImage else { return }
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
    }
    
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
