//
//  ViewModel.swift
//  MediaCypher-J22
//
//  Created by mac on 2/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation


protocol mediaDelegate: class {
    func updateUI()
}

class ViewModel {
    
    var content:[Content] = []{
        didSet {
            delegate?.updateUI()
        }
    }
    
    weak var delegate: mediaDelegate?
    
    init(){
        //CoreManager.shared.deleteAllContent()
        reloadContent()
    }
    
    func reloadContent(){
        content = CoreManager.shared.loadAllContent()
    }
}
