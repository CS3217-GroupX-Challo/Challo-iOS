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

    @Published var blogTitle: String = "" {
        didSet {
            interactor.updateBlog(title: blogTitle)
        }
    }
    @Published var blogBody: String = "" {
        didSet {
            interactor.updateBlog(body: blogBody)
        }
    }

    func saveBlogDraft() {

    }

}
