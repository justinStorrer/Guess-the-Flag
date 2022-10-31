//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Justin Storrer on 10/21/22.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Nigeria", "Poland", "Russia", "Spain", "Italy", "Monaco", "UK", "US"].shuffled()
    @State private var countryEmojis = ["Estonia": "🇪🇪", "France": "🇫🇷", "Germany": "🇩🇪", "Ireland": "🇮🇪", "Nigeria": "🇳🇬", "Poland": "🇵🇱", "Russia": "🇷🇺", "Spain": "🇪🇸", "Italy": "🇮🇹", "Monaco": "🇲🇨", "UK": "🇬🇧", "US": "🇺🇸"]
    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .topLeading, startRadius: 200, endRadius: 1300)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .foregroundColor(.white)
                    .font(.title.weight(.bold))
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.white)
                            .foregroundStyle(.secondary)
                        Text("\(countries[correctAnswer])")
                            .font(.largeTitle.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    
                    ForEach(0..<4) { number in
                        Button {
                            // flag was tapped
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(radius: 30)
                        }
                    }
                }
                .frame(maxWidth: 325)
                .padding(.vertical, 20)
                .background(.thinMaterial.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                VStack {
                    Text("Score:")
                        .font(.headline.weight(.semibold))
                        .foregroundColor(.white)
                    Text("\(score)")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(.thinMaterial.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 5
        } else {
            let correctFlag = countryEmojis[countries[correctAnswer]]!
            scoreTitle = "Wrong! The flag of \(countries[correctAnswer]) is \(correctFlag)"
            score -= 2
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
