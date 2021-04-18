//
//  LabeledImage.swift
//  Challo
//
//  Created by Ying Gao on 17/4/21.
//

import SwiftUI

struct LabeledImage: View {
    var imageName: String
    var label: String
    var textWidth: CGFloat

    private var textMaxHeight: CGFloat
    private var textToImageSizeRatio: CGFloat

    init(imageName: String, label: String, textWidth: CGFloat,
         textMaxHeight: CGFloat = 50,
         textToImageSizeRatio: CGFloat = 3) {
        self.imageName = imageName
        self.label = label
        self.textWidth = textWidth
        self.textMaxHeight = textMaxHeight
        self.textToImageSizeRatio = textToImageSizeRatio
    }

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: textWidth / textToImageSizeRatio)
                .padding(.bottom, 5)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.themeAccent)
                .frame(maxWidth: textWidth, maxHeight: textMaxHeight)
                .multilineTextAlignment(.center)
        }
    }
}

struct LabeledImage_Previews: PreviewProvider {
    static var previews: some View {
        LabeledImage(imageName: "person.crop.circle",
                     label: "Really really long text",
                     textWidth: 100)
    }
}
