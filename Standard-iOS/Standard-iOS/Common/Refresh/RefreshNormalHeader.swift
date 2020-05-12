//
//  WCRefreshHeaderAnimator.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/5/9.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit
import MJRefresh

public class RefreshPhotosNormalHeader: MJRefreshNormalHeader {
    
}

public protocol RefreshFinishedProtocol where Self: UIViewController {
    var collectionView: UICollectionView! { get }
    
    var footer: MJRefreshAutoNormalFooter? { get }
    
    var header: RefreshPhotosNormalHeader? { get }
    
    func endFooterRefreshing(with hasMore: Bool)
    
    func endHeaderRefreshing(with hasMore: Bool)
    
    func endHeaderRefreshingWhenError()
    
    func endFooterRefreshingWhenError()
    
}

extension RefreshFinishedProtocol {
    func endFooterRefreshing(with hasMore: Bool) {
        if self.collectionView.mj_footer.isSome(), hasMore == false {
            self.collectionView.mj_footer.endRefreshingWithNoMoreData()
        }
        if self.collectionView.mj_footer.isSome(), hasMore == true {
            self.collectionView.mj_footer.endRefreshing()
        }
        self.collectionView.reloadData()
    }

    func endHeaderRefreshing(with hasMore: Bool) {
        if self.collectionView.mj_footer.isSome(), hasMore == false {
            self.collectionView.mj_footer.endRefreshingWithNoMoreData()
        }
        if self.collectionView.mj_footer.isNone(), hasMore == true {
            self.collectionView.mj_footer = self.footer
        }
        if self.collectionView.mj_footer.isSome(), hasMore == true {
            self.collectionView.mj_footer.resetNoMoreData()
        }
        self.collectionView.mj_header.endRefreshing()
        self.collectionView.reloadData()
    }
    
    func endHeaderRefreshingWhenError() {
        self.collectionView.mj_header.endRefreshing()
        self.collectionView.reloadData()
    }
    
    func endFooterRefreshingWhenError() {
        self.collectionView.mj_footer.endRefreshing()
        self.collectionView.reloadData()
    }
}

public protocol TableRefreshEndProtocol where Self: UIViewController {
    var tableView: UITableView! { get }
    
    var footer: MJRefreshAutoNormalFooter? { get }
    
    var header: RefreshPhotosNormalHeader? { get }
    
    func endFooterRefreshing(with hasMore: Bool)
    
    func endHeaderRefreshing(with hasMore: Bool)
    
    func endHeaderRefreshingWhenError()
    
    func endFooterRefreshingWhenError()
}

extension TableRefreshEndProtocol {
    func endFooterRefreshing(with hasMore: Bool) {
        if self.tableView.mj_footer.isSome(), hasMore == false {
            self.tableView.mj_footer.endRefreshingWithNoMoreData()
        }
        if self.tableView.mj_footer.isSome(), hasMore == true {
            self.tableView.mj_footer.endRefreshing()
        }
        self.tableView.reloadData()
    }
    
    func endHeaderRefreshing(with hasMore: Bool) {
        if self.tableView.mj_footer.isSome(), hasMore == false {
            self.tableView.mj_footer.endRefreshingWithNoMoreData()
        }
        if self.tableView.mj_footer.isNone(), hasMore == true {
            self.tableView.mj_footer = self.footer
        }
        if self.tableView.mj_footer.isSome(), hasMore == true {
            self.tableView.mj_footer.resetNoMoreData()
        }
        self.tableView.mj_header.endRefreshing()
        self.tableView.reloadData()
    }
    
    func endHeaderRefreshingWhenError() {
        self.tableView.mj_header.endRefreshing()
        self.tableView.reloadData()
    }
    
    func endFooterRefreshingWhenError() {
        self.tableView.mj_footer.endRefreshing()
        self.tableView.reloadData()
    }
}
