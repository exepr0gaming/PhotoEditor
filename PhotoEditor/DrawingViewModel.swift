//
//  DrawingViewModel.swift
//  PhotoEditor
//
//  Created by Andrew Kurdin on 30.07.2023.
//

import SwiftUI
import PencilKit

class DrawingViewModel: ObservableObject {
  @Published var showImagePicker = false
  @Published var imageData: Data = Data(count: 0)
  
  // canvas for drawing with PencilKit
  @Published var canvas = PKCanvasView()
  
  @Published var toolPicker = PKToolPicker()
  
  // cancel function
  func cancelImageEditing() {
    imageData = Data(count: 0)
    canvas = PKCanvasView()
  }
  
}
