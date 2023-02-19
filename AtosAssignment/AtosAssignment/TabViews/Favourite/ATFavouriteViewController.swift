//
//  ATFavouriteViewController.swift
//  AtosAssignment
//
//  Created by Admin on 19/02/23.
//

import Foundation
import UIKit

class ATFavouriteViewController: UIViewController {
    @IBOutlet weak var favPostTableView: UITableView!
    
    var favPosts: [Posts] = []
    let viewModel = ATFavouritePostModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        favPostTableView.dataSource = self
        favPostTableView.delegate = self
        
        viewModel.arrFavPosts.addObservale { favPostArr in
            self.favPosts = favPostArr ?? []
            DispatchQueue.main.async {
                self.favPostTableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getData()
    }
}

extension ATFavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ATPostCell", for: indexPath) as? ATPostCell {
            let post = favPosts[indexPath.row]
            cell.labelId.text = "ID - " + String(post.id)
            cell.labelUserId.text = "UserID - " + String(post.userId)
            cell.labelTitle.text = "Title - " + (post.title ?? "")
            cell.labelBody.text = "Body - " + (post.body ?? "")
            return cell
        }
        return UITableViewCell()
    }
}

extension ATFavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
