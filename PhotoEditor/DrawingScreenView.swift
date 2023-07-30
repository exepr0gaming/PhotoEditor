//
//  DrawingScreenView.swift
//  PhotoEditor
//
//  Created by Andrew Kurdin on 30.07.2023.
//

import SwiftUI
import PencilKit

struct DrawingScreenView: View {
  @EnvironmentObject var drawingVM: DrawingViewModel
  
    var body: some View {
      ZStack {
        GeometryReader { proxy -> AnyView in
          let size = proxy.frame(in: .global).size
          
          return AnyView(
            // UIKit PencilKit drawing View
            CanvasView(canvas: $drawingVM.canvas, imageData: $drawingVM.imageData, toolPicker: $drawingVM.toolPicker, rect: size)
          )
        }
      }
    }
}

struct DrawingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct CanvasView: UIViewRepresentable {
  // since we need to get the drawings so were bindings
  @Binding var canvas: PKCanvasView
  @Binding var imageData: Data
  @Binding var toolPicker: PKToolPicker // карандаши для черчения
  
  // View size
  var rect: CGSize
  
  func makeUIView(context: Context) -> some PKCanvasView {
    canvas.isOpaque = false // для рисования без исчезновения фона
    canvas.backgroundColor = .clear
    canvas.drawingPolicy = .anyInput
    
    // basically were setting image to the back of the canvas
    if let image = UIImage(data: imageData) {
      let imageView = UIImageView(image: image)
      imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
      imageView.contentMode = .scaleAspectFit
      imageView.clipsToBounds = true
      
      let canvasSubview = canvas.subviews[0]
      canvasSubview.addSubview(imageView)
      canvasSubview.sendSubviewToBack(imageView)
      
      //showing tool Picker
      // were setting it as first responder and making it as visible
      toolPicker.setVisible(true, forFirstResponder: canvas)
      toolPicker.addObserver(canvas)
      canvas.becomeFirstResponder()
    }
    
    return canvas
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
    // update UI will update for each actions
    
    
  }
}
