//
//  ATHomeViewModel.swift
//  AtosAssignment
//
//  Created by Admin on 19/02/23.
//

import Foundation

class ATPostViewModel {
    
    var arrPosts: ATObservable <[Posts]> = ATObservable(value: [])
    private var getPostService = ATGetPostsService()

    func getData() {
        getPostService.delgate = self
        getPostService.getData()
    }
}

extension ATPostViewModel: ATGetPostServiceProtocol {
    func didReceivedPosts(posts: [Posts]) {
        arrPosts.value = posts
    }
}
