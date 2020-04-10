//
//  GifterController.swift
//  SecretSanta
//
//  Created by Sean Jones on 4/10/20.
//  Copyright © 2020 Sean Jones. All rights reserved.
//

import Foundation

typealias  Gifter = String 
class GifterController {
    
    //MARK:- PROPERTIES
    static let shared = GifterController()
     static let gifterKey = "gifterKey"
    
    var gifters: [Gifter] = []
    
    init(){
        loadGifters()
    }
    
    
    func createGifter(gifter: Gifter){
        gifters.append(gifter)
        saveGifter()
    }
    
    func deleteGifter(gifter: Gifter){
        guard let index = gifters.firstIndex(of: gifter) else {return}
        gifters.remove(at:index)
        saveGifter()
    }
    
    func saveGifter(){
        UserDefaults.standard.set(gifters, forKey: GifterController.gifterKey)
    }
    
    
   
    
    func shuffle(){
        var shuffledGifters: [Gifter] = []
        for gifter in gifters {
            
            let shuffle = Int(arc4random_uniform(UInt32(shuffledGifters.count)))
            shuffledGifters.insert(gifter, at: shuffle)
            gifters = shuffledGifters
        }
    }
    
    func loadGifters(){
        
        guard let savedGifters = UserDefaults.standard.array(forKey: GifterController.gifterKey) as?
            [Gifter] else {return}
        self.gifters = savedGifters
    }
    
}
//END OF CLASS
