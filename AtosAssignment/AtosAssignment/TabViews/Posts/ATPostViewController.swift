//
//  ATPostViewController.swift
//  AtosAssignment
//
//  Created by Admin on 19/02/23.
//

import Foundation
import UIKit

//Best practice - Using common table for both post and view, this is for assignment purpose only
class ATPostViewController : UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    
    let postViewModel = ATPostViewModel()
    var posts: [Posts] = []

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.dataSource = self
        postTableView.delegate = self
        
        postViewModel.arrPosts.addObservale { posts in
            self.posts = posts ?? []
            DispatchQueue.main.async {
                self.postTableView.reloadData()
                self.activityIndicator.isHidden = true
            }
        }
        postViewModel.getData()
    }
}

extension ATPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ATPostCell", for: indexPath) as? ATPostCell {
            
            let post = posts[indexPath.row]
            
            cell.labelId.text = "ID - " + String(post.id)
            cell.labelUserId.text = "UserID - " + String(post.userId)
            cell.labelTitle.text = "Title - " + (post.title ?? "")
            cell.labelBody.text = "Body - " + (post.body ?? "")
            
            return cell

        }
        return UITableViewCell()
    }
}

extension ATPostViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt indexPath")
        let post = posts[indexPath.row]
        post.isFavourite = !post.isFavourite
        ATCoreDataPostsService.shared.saveCoreDataChanges()
        
        print("Favs - \(ATCoreDataPostsService.shared.getFavouritePosts())")
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
