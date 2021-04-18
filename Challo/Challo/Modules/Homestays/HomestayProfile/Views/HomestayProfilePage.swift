//
//  HomestayProfilePage.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayProfilePage: View {
    @EnvironmentObject var presenter: HomestayProfilePresenter
    @Environment(\.presentationMode) var presentationMode
    
    func makeStickyBarContent(_ homestay: Homestay) -> some View {
        Text("\(Int(homestay.fee))").bold() + Text(" Rp / night")
    }
    
    var ctaButtonContent: some View {
        Text("Chat with Host")
            .onTapGesture {
                presenter.isChatSheetOpen = true
            }
    }
    
    var body: some View {
        EntityProfilePage<HomestayProfilePresenter>(defaultImage: "guides-background",
                                                    detailsContent: { AnyView(HomestayProfileDetails()) },
                                                    ctaButtonContent: { AnyView(ctaButtonContent) },
                                                    stickyBarContent: { trail in AnyView(makeStickyBarContent(trail)) })
            .sheet(isPresented: $presenter.isChatSheetOpen, content: {
                HomestayHostChat().environmentObject(presenter)
            })
            .alert(isPresented: $presenter.isShowingAlert) {
                Alert(title: Text(presenter.alertTitle),
                      message: Text(presenter.alertMessage),
                      dismissButton: Alert.Button.default(
                        Text("Okay"), action: {
                            if self.presenter.isSuccessAlert {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                      )
                )
            }
    }
}
