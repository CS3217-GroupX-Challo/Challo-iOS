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
            savingEnabled = interactor.isValidBlogPostTitle
        }
    }
    @Published var blogBody = "" {
        didSet {
            interactor.updateBlog(body: blogBody)
        }
    }

    @Published var savingEnabled = false

    func saveBlogDraft() {
        // TODO: Implement persistence
    }

    func publish() {
        // TODO: Implement API
    }

}
