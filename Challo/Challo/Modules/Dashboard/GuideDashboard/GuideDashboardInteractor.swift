//
//  GuideDashboardInteractor.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import Foundation

class GuideDashboardInteractor: InteractorProtocol {
    weak var presenter: GuideDashboardPresenter!

    let userState: UserStateProtocol
    let guideAPI: GuideAPIProtocol
    let userAPI: UserAPIProtocol
    let updateUserChat: ((_ name: String, _ email: String) -> Void)

    init(userState: UserStateProtocol,
         userAPI: UserAPIProtocol,
         guideAPI: GuideAPIProtocol,
         updateUserChat: @escaping ((_ name: String, _ email: String) -> Void)) {
        self.userState = userState
        self.userAPI = userAPI
        self.guideAPI = guideAPI
        self.updateUserChat = updateUserChat
    }

    func checkOnboardingStatus() {
        if let guide = userState.user as? Guide {
            presenter.setHasGuideOnboarded(value: hasGuideOnboarded(guide: guide))
            return
        }
        
        guard let id = UUID(uuidString: userState.userId) else {
            fatalError("User should be logged in with a valid UUID")
        }
        
        guideAPI.getGuide(guideId: id) { guide in
            self.presenter.setHasGuideOnboarded(value: self.hasGuideOnboarded(guide: guide))
        }
    }

    private func hasGuideOnboarded(guide: Guide) -> Bool {
        !guide.trails.isEmpty
    }
}

extension GuideDashboardInteractor: ProfileUpdaterInteractor { }
