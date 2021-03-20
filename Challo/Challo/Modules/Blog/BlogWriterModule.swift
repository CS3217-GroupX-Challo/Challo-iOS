//
//  BlogWriterModule.swift
//  Challo
//
//  Created by Ying Gao on 20/3/21.
//

import SwiftUI

final class BlogWriterModule: ViperModuleProtocol {

    static func assemble() -> (view: AnyView, presenter: BlogWriterPresenter) {
        let interactor = BlogWriterInteractor()
        let presenter = BlogWriterPresenter()
        let router = BlogWriterRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        let view = AnyView(BlogWriter(presenter: presenter))
        return (view, presenter)
    }

}
