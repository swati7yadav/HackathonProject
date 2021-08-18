//
//  FeedListViewModel.swift
//  HackathonProject
//
//  Created by Swati Yadav on 17/08/21.
//

import UIKit

final class FeedListViewModel {
    weak var service: FeedListServiceProtocol?
    var feedListModel: FeedListModel?
    var onRefreshHandling: (() -> Void)?
    var onErrorHandling: ((ErrorResult?) -> Void)?
    var feedListArray = [ChildrenData]()
    
    init(service: FeedListServiceProtocol = FeedListService.shared) {
        self.service = service
    }
    
    // Get feed list data
    func getFeedListData() {
        var afterLink = ""
        if let obj = feedListModel, let data = obj.data, data.after != nil {
            afterLink = obj.data?.after ?? ""
        }
        
        service?.fetchFeedList(afterLink: afterLink, completion: { (result) in
            switch result {
            case .success(let feedModel):
                self.feedListModel = feedModel
                if let array = feedModel.data?.children {
                    self.feedListArray.append(contentsOf: array)
                }
                self.onRefreshHandling?()
                break
            case .failure(let error):
                self.onErrorHandling?(ErrorResult.network(string: error.localizedDescription))
                break
            }
        })
    }
}
