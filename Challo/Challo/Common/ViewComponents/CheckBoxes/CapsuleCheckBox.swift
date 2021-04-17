//
//  CapsuleCheckBox.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

struct CapsuleCheckBox: View {
    let label: String
    @State var width: CGFloat
    @Binding var isChecked: Bool

    @State var trimValue: CGFloat = 0
    @State var removeText: Bool = false
    
    var animatableData: CGFloat {
        get { trimValue }
        set { trimValue = newValue }
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .trim(from: 0, to: trimValue)
                .stroke(lineWidth: 2)
                .frame(width: width, height: 70)
                .foregroundColor(isChecked ? Color.green : Color.gray)
                .overlay(
                    Capsule()
                        .fill(isChecked ? Color.green : Color.gray.opacity(0.2))
                        .frame(width: width - 10, height: 60)
                )
            if isChecked {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.white)
                    .opacity(Double(trimValue))
            }
            if !removeText {
                Text(label)
            }
        }.onTapGesture {
            if !isChecked {
                removeText.toggle()
                withAnimation {
                    width = 70
                }
                withAnimation(Animation.easeIn(duration: 0.7)) {
                    trimValue = 1
                    isChecked.toggle()
                }
            } else {
                withAnimation {
                    trimValue = 0
                    width = 200
                    isChecked.toggle()
                    removeText.toggle()
                }
            }
        }
    }
}

struct CapsuleCheckBox_Previews: PreviewProvider {
    @State static var isChecked = false

    static var previews: some View {
        CapsuleCheckBox(label: "Check me", width: 200, isChecked: $isChecked)
    }
}
