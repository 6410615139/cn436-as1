//
//  ContentView.swift
//  Number Guessing Game
//
//  Created by Supakrit Nithikethkul on 21/1/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @State var game = Game(start: 1, stop: 100)
    @State var start: Int = 1
    @State var stop: Int = 100
    @State var guess = "?"
    @State var slider_guess: Double = 0
    @State var win = false
    @State var result = "Result"
    
    var body: some View {
        
        VStack {
            // Displaying the count in the top right corner
            HStack {
                Spacer()
                Text("Attempts: \(game.count)")
                    .padding()
            }
            // Setting
            HStack {
                Text("Range")
                TextField("Start Range", value: $start, formatter: NumberFormatter())
                Text("-")
                TextField("End Range", value: $stop, formatter: NumberFormatter())
                Button("Reset") {
                    game.setStart(start: start)
                    game.setStop(stop: stop)
                    game.startNewGame()
                    guess = "?"
                    slider_guess = 0
                    result = "Result"
                }
                .padding() // Add padding around the button's text
                .background(Color.green) // Set the background color of the button
                .foregroundColor(.black) // Set the text color of the button
                .cornerRadius(30) // Optional: to round the corners of the button
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            
            // main
            HStack (alignment: .center, spacing: 20){
                VStack {
                    ColorSlider(value: $slider_guess, startRange: game.getStart(), endRange: game.getStop(), trackColor: .red)
                        .onChange(of: slider_guess) { newValue in
                            guess = String(format: "%.0f", newValue) }
                    .frame(height: 170)
                }
                VStack {
                    TextField("Enter a number", text: $guess)
                        .keyboardType(.numberPad) // Setting keyboard type to number pad
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 50)
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.red)
                                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                                .onChange(of: guess) { newValue in
                                    slider_guess = Double(newValue) ?? slider_guess // Use the existing value if conversion fails
                                }
                        )
                    Text(result)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.black)
                                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                        )
                    Button("Guess!") {
                        if let guessNumber = Int(guess) {
                            let resultCheck = game.check(guess: guessNumber)
                            switch resultCheck {
                            case 0:
                                win = true
                            case -1:
                                result = "Higher"
                            case 1:
                                result = "Lower"
                            default:
                                result = "Error, there is something wrong."
                            }
                        }
                    }
                    .padding() // Add padding around the button's text
                    .background(Color.green) // Set the background color of the button
                    .foregroundColor(.black) // Set the text color of the button
                    .cornerRadius(30) // Optional: to round the corners of the button
                }
            }
            .frame(minHeight: 230)
            
            HStack {
            
            }
        }
        .alert(isPresented: $win) {
            Alert(
                title: Text("You Won!"),
                message: Text("It took you \(game.count) attempts to find \(game.the_number)"),
                dismissButton: .default(Text("OK")) {
                    game.startNewGame()
                    guess = "?"
                    slider_guess = 0
                    result = "Result"
                }
            )
        }
        
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var startRange: Int
    var endRange: Int
    var trackColor: Color

    var body: some View {
        VStack {
            Button("+") {
                value+=1
            }
            .bold()
            Spacer()
            Text("\t"+String(endRange))
                .rotationEffect(.degrees(-90))
                .padding()
            Slider(value: $value, in: Double(startRange)...Double(endRange))
                .accentColor(trackColor)
                .rotationEffect(.degrees(-90))
                .padding()
            Text(String(startRange))
                .rotationEffect(.degrees(-90))
                .padding()
            Button("-") {
                value-=1
            }
            .bold()
            Spacer()
        }
        .frame(width: 150)
    }
}

#Preview {
    ContentView()
}
