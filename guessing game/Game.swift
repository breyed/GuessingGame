import AVFoundation
import SwiftUI

struct Game: View {
	@State var minAnswer = 0
	@State var maxAnswer = 0
	@State var answer = 0
	@State var guess = ""
	@State var correct = false
	@State var hint = ""
	
	var body: some View {
		VStack {
			Text("I'm thinking of a number from \(minAnswer) to \(maxAnswer)")
				.padding(.bottom, 200.0)

			if correct {
				Button(action: startNewGame) {
					Text("Next").font(.system(size: 40)).bold()
					Image(systemName: "arrowshape.turn.up.right.fill").resizable().frame(width: 50, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
				}
				Image("FlyingCat")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(height: 200, alignment: .center)
			} else {
				Text(hint)
				HStack {
					TextField("Guess", text: $guess)
						.frame(width: 100)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.numberPad)
					Button(action: checkGuess) {
						Text("Enter")
					}
				}
			}
		}
		.padding(.all)
		.onAppear(perform: startNewGame)
	}

	private func checkGuess() {
		guard let guessNumber = Int(guess) else { return }
		if answer == guessNumber {
			correct = true
			hint = ""
		} else if answer < guessNumber {
			hint = "Too high"
		} else if answer > guessNumber {
			hint = "Too low"
		}
	}
	
	private func startNewGame() {
		switch maxAnswer {
		case 0: maxAnswer = 10
		case 10: maxAnswer = 25
		case 400: maxAnswer = 1000
		case 1000: ()
		default: maxAnswer = maxAnswer * 2
		}
	
		minAnswer = maxAnswer >= 100 ? maxAnswer / 2 : 1
		answer = Int.random(in: minAnswer ... maxAnswer)
		guess = ""
		correct = false
		hint = ""
	}
}

struct Game_Previews: PreviewProvider {
	static var previews: some View {
		Game(correct: true, hint: "Too high")
	}
}
