//
//  SRSplitViewController.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.splitView.delegate = self
        // Do view setup here.
    }
    
//    override func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
//        return proposedMinimumPosition - 50
//    }
//    
//    override func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
//        return proposedMaximumPosition - 250
//    }
//    
//    override func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
//        return proposedMinimumPosition - 200
//    }
    
//    override func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
////        NSView* rightView = [[splitView subviews] objectAtIndex:1];
////        NSLog(@"%@:%s returning %@",[self class], _cmd, ([subview isEqual:rightView])?@"YES":@"NO");
////        return ([subview isEqual:rightView]);
//
//        
//        return true
//    }
    
}
