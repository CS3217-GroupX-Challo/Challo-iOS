//
//  TrailProfilePage.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfilePage: View {
    @EnvironmentObject var presenter: TrailProfilePresenter
    
    var body: some View {
        EntityProfilePage<TrailProfilePresenter>(defaultImage: "guides-background",
                                                 detailsContent: { AnyView(TrailProfileDetails()) },
                                                 stickyBarContent: { AnyView(TrailProfileStickyBar()) })
    }
}
