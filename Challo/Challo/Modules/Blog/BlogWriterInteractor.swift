//
//  BlogWriterInteractor.swift
//  Challo
//
//  Created by Ying Gao on 20/3/21.
//

import Foundation

class BlogWriterInteractor: InteractorProtocol {

    private(set) var blogPost: BlogPost
    weak var presenter: BlogWriterPresenter!

    init(blogPost: BlogPost? = nil) {
        if let blogPost = blogPost {
            self.blogPost = blogPost
        } else {
            self.blogPost = BlogPost(author: UUID())
        }
    }

    func updateBlog(title: String? = nil, body: String? = nil) {
        if let newTitle = title {
            blogPost.title = newTitle
        }
        if let newBody = body {
            blogPost.body = newBody
        }
    }

}
