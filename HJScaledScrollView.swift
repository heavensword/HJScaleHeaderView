//
//  HJScaledScrollView.swift
//  HJScaleHeaderView
//
//  Created by Sword on 2/16/15.
//  Copyright (c) 2015 Sword. All rights reserved.
//

import UIKit

@objc protocol HJScaledScrollViewDelegate : NSObjectProtocol {
    optional func hjscaledScrollViewDidScrollUp(scrollView:HJScaledScrollView, contentOffset:CGPoint)
    optional func hjscaledScrollViewDidScrollDown(scrollView:HJScaledScrollView, contentOffset:CGPoint)
}


class HJScaledScrollView: UIScrollView {

    var _previousContentOffset:CGPoint?
    var _scollDelegate:HJScaledScrollViewDelegate?
    var _expandHeight:CGFloat!
    var _headerView:UIView!
    
    @IBOutlet weak var scollDelegate:HJScaledScrollViewDelegate? {
        set {
            _scollDelegate = newValue
        }
        get {
            return _scollDelegate
        }
    }
    
    @IBOutlet weak var headerView: UIView! {
        set {
            _headerView = newValue!
            var frame = _headerView.frame
            _headerView.frame = frame
            frame.origin.y = 0;
            frame.origin.x = 0
            frame.size.width = CGRectGetWidth(self.frame)
            _expandHeight = CGRectGetHeight(_headerView.frame)
            self.addSubview(_headerView)
        }
        get {
            return _headerView
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "contentOffset")        
    }
    
    override func layoutSubviews() {
        NSLog("self.frame %@", NSStringFromCGRect(self.frame))
        var frame = _headerView.frame
        frame.size.width = CGRectGetWidth(self.frame)
        _headerView.frame = frame
        
    }

    init(frame:CGRect, headerView:UIView) {
        super.init(frame: frame)
        self.frame = frame
        _previousContentOffset = CGPointZero
        self.addObserver(self, forKeyPath: "contentOffset", options:NSKeyValueObservingOptions.New, context: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _previousContentOffset = CGPointZero
        self.addObserver(self, forKeyPath: "contentOffset", options:NSKeyValueObservingOptions.New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "contentOffset" {
            NSLog("%@", object as UIScrollView)
            NSLog("%@", change as Dictionary)
            let scrollView = object as UIScrollView
            let scrollDown:Bool = _previousContentOffset!.y - scrollView.contentOffset.y >= 0
            _previousContentOffset = scrollView.contentOffset
            if scrollView.contentOffset.y - 20 <= 0 {
                self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
                var frame = self.headerView.frame
                frame.origin.y = scrollView.contentOffset.y
                frame.size.height = -1 * scrollView.contentOffset.y + _expandHeight
                _headerView.frame = frame;
            }
            else {
                if _expandHeight - scrollView.contentOffset.y <= 64 {
                    let inset = UIEdgeInsetsMake(scrollView.contentOffset.y, 0, 0, 0)
                    self.contentInset = inset
                    var frame = self.headerView.frame
                    frame.origin.y = scrollView.contentOffset.y
                    frame.size.height = 64
                    _headerView.frame = frame

                }
            }
        }
    }
}
