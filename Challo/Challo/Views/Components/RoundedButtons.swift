import SwiftUI

struct RoundedCornerButton: ButtonStyle {
 
    var color: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Color.white)
            .padding(10)
            .overlay(
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(color, lineWidth: 1)
               )
        }
}
