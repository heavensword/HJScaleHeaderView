//
//  ViewController.swift
//  HJScaleHeaderView
//
//  Created by Sword on 2/16/15.
//  Copyright (c) 2015 Sword. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HJScaledScrollViewDelegate {

    var headerViewHeight:CGFloat!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrollView: HJScaledScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerViewHeight = CGRectGetHeight(self.headerView.frame)
        self.navigationController?.navigationBarHidden = true
        let contentSize:CGSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 1800)
        self.scrollView.contentSize = contentSize
        self.scrollView.scollDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func hjscaledScrollViewDidScrollUp(scrollView:HJScaledScrollView, contentOffset:CGPoint) {
        if headerViewHeight - scrollView.contentOffset.y <= 64 {
            if true == self.navigationController?.navigationBarHidden {
                self.navigationController?.navigationBarHidden = false
                self.navigationController?.navigationBar.alpha = 0.4;
            }
        }
    }
    
    func hjscaledScrollViewDidScrollDown(scrollView:HJScaledScrollView, contentOffset:CGPoint) {
        if false == self.navigationController?.navigationBarHidden {
            self.navigationController?.navigationBarHidden = true
        }
    }

}

