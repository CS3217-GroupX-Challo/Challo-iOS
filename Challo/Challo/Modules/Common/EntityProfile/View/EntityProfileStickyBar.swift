//
//  EntityProfileStickyBar.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct EntityProfileStickyBar<Presenter: EntityProfilePresenter>: View {
    @EnvironmentObject var presenter: Presenter
    
    let ctaButtonContent: () -> AnyView
    let stickyBarContent: (Presenter.Entity) -> AnyView
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                UnwrapView(presenter.currentEntity) { entity in
                    stickyBarContent(entity)
                }
            }
            Spacer()
            Button(action: presenter.onTapBookCTAButton, label: {
                ctaButtonContent()
            })
            .padding()
            .foregroundColor(.white)
            .background(Color.themeTertiary)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.themeTertiary, lineWidth: 1))
            .padding([.top, .bottom], 10)
            .font(Font.system(size: 15, weight: .semibold))
            .disabled(!presenter.canUserClickCTA)
            
        }.padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: -5)
        )
    }
}
