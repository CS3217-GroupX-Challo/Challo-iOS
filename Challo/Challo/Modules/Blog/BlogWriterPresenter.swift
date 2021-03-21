//
//  BlogWriterPresenter.swift
//  Challo
//
//  Created by Ying Gao on 20/3/21.
//

import SwiftUI

class BlogWriterPresenter: PresenterProtocol {

    var interactor: BlogWriterInteractor! {
        didSet {
            blogTitle = interactor.blogPost.title
            blogBody = interactor.blogPost.body
        }
    }
    var router: BlogWriterRouter?

    @Published var blogTitle = "" {
        didSet {
            interactor.updateBlog(title: blogTitle)
        }
    }
    @Published var blogBody = "" {
        didSet {
            interactor.updateBlog(body: blogBody)
        }
    }

    var savingDisabled: Bool {
        !interactor.isValidBlogPostTitle
    }

    var publishingDisabled: Bool {
        !interactor.canBePublished
    }

    func saveBlogDraft() {
        // TODO: Implement persistence
        guard !savingDisabled else {
            return
        }
    }

    func publish() {
        // TODO: Implement API
        guard !publishingDisabled else {
            return
        }
    }

}
