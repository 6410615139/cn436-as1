//
//  Game.swift
//  Number Guessing Game
//
//  Created by Supakrit Nithikethkul on 21/1/2567 BE.
//

struct Game {
    var the_number = Int.random(in: 1...100)
    var count = 0
    private var start: Int
    private var stop: Int
    
    init(start: Int, stop: Int) {
        self.start = start
        self.stop = stop
    }
    
    mutating func check(guess: Int) -> Int {
        self.count+=1
        if (guess == the_number) { // win
            return 0
        } else if (guess < the_number) { // "The number is greater than your guess."
            return -1
        } else if (guess > the_number) { // "The number is less than your guess."
            return 1
        } else { // "Error, there is something wrong."
            return 2
        }
    }
    
    mutating func startNewGame() {
        count = 0
        let start = self.getStart()
        let stop = self.getStop()
        the_number = Int.random(in: start...stop)
    }
    
    mutating func setStart(start: Int) {
        self.start = start
    }
    
    mutating func setStop(stop: Int) {
        self.stop = stop
    }
    
    func getStart() -> Int {
        self.start
    }
    
    func getStop() -> Int {
        self.stop
    }
    
}
