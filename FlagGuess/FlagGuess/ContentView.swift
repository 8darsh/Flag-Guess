//
//  ContentView.swift
//  FlagGuess
//
//  Created by Adarsh Singh on 01/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countScore = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var counter = 0
    @State private var animationAmount = 0.0
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.cyan, .orange]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Text("Guess The Flag")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                VStack (spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
//                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                            if scoreTitle == "Correct" {
                                withAnimation{
                                animationAmount += 360
                            }
                            }
                                
                            
                        }label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Score: \(countScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
            }
            .padding()
        }
        .alert(scoreTitle, isPresented:$showingScore){
            if counter != 7{
                Button("Continue", action: askQuestion)
            }
            else
            {
                Button("Restart",action: restartGame)
            }
        }message: {
            if counter != 7{
                Text("Your Score is \(countScore)")
            }
            else{
                Text("Your Final Score is \(countScore)")
            }
        }
        
    }
    func flagTapped(_ number:Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            countScore += 1
            
        }
        else{
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            countScore -= 1
        }
        showingScore = true
    }
    func askQuestion(){
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        counter += 1
    }
    func restartGame(){
        counter = 1
        countScore = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
//        counter += 1
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
