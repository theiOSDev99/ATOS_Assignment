//
//  ATFavouritePostModel.swift
//  AtosAssignment
//
//  Created by Admin on 20/02/23.
//

import Foundation

class ATFavouritePostModel {
    
    var arrFavPosts: ATObservable <[Posts]> = ATObservable(value: [])

    func getData() {
        arrFavPosts.value = ATCoreDataPostsService.shared.getFavouritePosts()
    }
}
