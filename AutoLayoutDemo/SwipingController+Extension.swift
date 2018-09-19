//
//  SwipingController+Extension.swift
//  AutoLayoutDemo
//
//  Created by Demo on 19.09.2018.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit

extension SwipingVC {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_ ) in
            self.collectionViewLayout.invalidateLayout()
            
            
            if self.pageControl.currentPage == 0 {
                
                self.collectionView?.contentOffset = .zero
            } else {
                
                // current page olduğu zaman horizontally center yap.
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                
            }
            
            
            
        }) { (_) in
            
        }
        
    }
    
}
