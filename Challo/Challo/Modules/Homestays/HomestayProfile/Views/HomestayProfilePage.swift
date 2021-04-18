//
//  HomestayProfilePage.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayProfilePage: View {
    @EnvironmentObject var presenter: HomestayProfilePresenter
    
    var body: some View {
        EntityProfilePage<HomestayProfilePresenter>(defaultImage: "guides-background",
                                                    detailsContent: { AnyView(TrailProfileDetails()) },
                                                    stickyBarContent: { AnyView(TrailProfileStickyBar()) })
    }
}
