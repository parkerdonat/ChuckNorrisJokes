//
//  JokeController.swift
//  funFacts
//
//  Created by Parker Donat on 7/19/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import Foundation

class JokeController {
    
    static let sharedInstance = JokeController()
    
    let kJokes = "jokes"
    
    var jokes: [Joke] = []
    
    init() {
        self.loadFromPersistentStorage()
    }
    
    func addJoke(joke: Joke) {
        jokes.append(joke)
        self.saveToPersistantStorage()
    }
    
    func removeJoke(joke: Joke) {
        if let jokeIndex = jokes.indexOf(joke) {
            jokes.removeAtIndex(jokeIndex)
        }
        self.saveToPersistantStorage()
    }
    
    func saveToPersistantStorage() {
        var jokeDictionaryArray: [[String: AnyObject]] = []
        for joke in jokes {
            let jokeDictionary = joke.dictionaryCopy
            jokeDictionaryArray.append(jokeDictionary)
        }
        NSUserDefaults.standardUserDefaults().setObject(jokeDictionaryArray, forKey: kJokes)
    }
    
    func loadFromPersistentStorage() {
        if let jokeDictionaryArray = NSUserDefaults.standardUserDefaults().objectForKey(kJokes) as? [[String: AnyObject]] {
            var jokesArray: [Joke] = []
            for jokeDictionary in jokeDictionaryArray {
                if let joke = Joke(dictionary: jokeDictionary) {
                    jokesArray.append(joke)
                }
            }
            self.jokes = jokesArray
        }
    }
}