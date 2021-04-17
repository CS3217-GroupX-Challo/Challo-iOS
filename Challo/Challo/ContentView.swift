import SwiftUI

struct ContentView: View {

    let userState: UserStateProtocol

    var MainContainer: some View {
        MainContainerModule(userState: userState).assemble().view
            .onAppear {
                let trailStore = TrailStore(repository: AnyPersistenceRepoProtocol(TrailDetailsRepository()),
                                            convertor: TrailModelConvertor(convertor: AreaModelConvertor()))
                /*
                 let trail1 = Trail(trailId: UUID(), title: "s", description: "test",
                                    rating: 0, difficulty: TrailDifficulty.Easy,
                                    positions: [], distance: 12, duration: 12, elevation: 12,
                                    images: [], area: Area(areaId: UUID(), village: "ss",
                                                           division: "ss", state: "ss",
                                                           country: "ss"),
                                    guideIds: [], numOfReviews: 1, lowestFee: 2,
                                    tags: [], landmarks: [])
                 let trail2 = Trail(trailId: UUID(), title: "ss", description: "test",
                                    rating: 0, difficulty: TrailDifficulty.Easy,
                                    positions: [], distance: 12, duration: 12, elevation: 12,
                                    images: [], area: Area(areaId: UUID(), village: "ss",
                                                           division: "ss", state: "ss",
                                                           country: "ss"),
                                    guideIds: [], numOfReviews: 1, lowestFee: 2,
                                    tags: [], landmarks: [])
                 let trail3 = Trail(trailId: UUID(), title: "sas", description: "test",
                                    rating: 0, difficulty: TrailDifficulty.Easy,
                                    positions: [], distance: 12, duration: 12, elevation: 12,
                                    images: [], area: Area(areaId: UUID(), village: "ss",
                                                           division: "ss", state: "ss",
                                                           country: "ss"),
                                    guideIds: [], numOfReviews: 1, lowestFee: 2,
                                    tags: [], landmarks: [])
                 */
                // trailStore.save(models: [trail1, trail2, trail3])
                print(trailStore.getAll().count)
            }
    }

    var body: some View {
        MainContainer
    }
}
