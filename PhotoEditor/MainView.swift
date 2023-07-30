//
//  MainView.swift
//  PhotoEditor
//
//  Created by Andrew Kurdin on 30.07.2023.
//

import SwiftUI

struct MainView: View {
  @StateObject var drawingVM = DrawingViewModel()
  
    var body: some View {
      NavigationView {
        VStack {
          if let uiImage = UIImage(data: drawingVM.imageData) {
            DrawingScreenView()
              .environmentObject(drawingVM)
            
            //settings cancel Btn if image selected
              .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                  Button {
                    drawingVM.cancelImageEditing()
                  } label: { Image(systemName: "xmark") }
                }

              }
            
          } else {
            // show image picker button
            Button {
              drawingVM.showImagePicker.toggle()
            } label: {
              Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.black)
                .frame(width: 50, height: 50)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.25), radius: 5, x: 5, y: 5)
            }
            
          }
        }
          .navigationTitle("Image Editor")
      }
      // show imagePicker to pick image
      .sheet(isPresented: $drawingVM.showImagePicker) {
        ImagePicker(showPicker: $drawingVM.showImagePicker, imageData: $drawingVM.imageData)
      }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
