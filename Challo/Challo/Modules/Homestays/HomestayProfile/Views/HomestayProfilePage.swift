//
//  HomestayProfilePage.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayProfilePage: View {
    @EnvironmentObject var presenter: HomestayProfilePresenter
    
    func makeStickyBarContent(_ homestay: Homestay) -> some View {
        Text("\(homestay.fee)").bold() + Text(" Rp / night")
    }
    
    var ctaButtonContent: some View {
        Text("Chat with Host")
    }
    
    var body: some View {
        EntityProfilePage<HomestayProfilePresenter>(defaultImage: "guides-background",
                                                    detailsContent: { AnyView(TrailProfileDetails()) },
                                                    ctaButtonContent: { AnyView(ctaButtonContent) },
                                                    stickyBarContent: { trail in AnyView(makeStickyBarContent(trail)) })
    }
}
