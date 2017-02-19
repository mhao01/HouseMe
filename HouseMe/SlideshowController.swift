//
//  SlideshowController.swift
//  HouseMe
//
//  Created by Patrick Chao on 2/18/17.
//  Copyright © 2017 ChaoHaoBerkeley. All rights reserved.
//

import Foundation
import UIKit


class SlideshowController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        scrollView.delegate = self
        scrollView.auk.settings.preloadRemoteImagesAround = 1
        
        // Turn on the image logger. The download log will be visible in the Xcode console
        Moa.logger = MoaConsoleLogger

    }
    
    
    /// Animate scroll view on orientation change
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        guard let pageIndex = scrollView.auk.currentPageIndex else { return }
        let newScrollViewWidth = size.width // Assuming scroll view occupies 100% of the screen width
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.scrollView.auk.scrollToPage(atIndex: pageIndex, pageWidth: newScrollViewWidth, animated: false)
            }, completion: nil)
    }
    
    
    func addImage(image: UIImage) {
        images.append(image)
        self.reloadData(image: image)
    }
    
    func reloadData(image: UIImage) {
        scrollView.auk.show(image: image)
    }
}

