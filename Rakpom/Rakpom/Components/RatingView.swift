//
//  RatingView.swift
//  Rakpom
//
//  Created by CatMeox on 26/6/2567 BE.
//

import SwiftUI

struct RatingView: View {
  @Binding var rating: Int
  
  var label = ""
  var maximumRating = 5
  
  var offImage: Image?
  var onImage = Image(systemName: "star.fill")
  
  var offColor = Color.halfGray
  var onColor = Color.yellow
  
  var body: some View {
    HStack {
      if label.isEmpty == false {
        Text(label)
      }
      
      ForEach(1..<maximumRating + 1, id: \.self) { number in
        Button {
          rating = number
        } label: {
          image(for: number)
            .resizable()
            .frame(width: 32, height: 32)
            .foregroundStyle(number > rating ? offColor : onColor)
        }
      }
      .buttonStyle(.plain)
    }
  }
  
  func image(for number: Int) -> Image {
    if number > rating {
      offImage ?? onImage
    } else {
      onImage
    }
  }
}

#Preview {
  RatingView(rating: .constant(4))
}
