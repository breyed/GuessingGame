import AVFoundation
import SwiftUI

struct Game: View {
	@State var minAnswer = 0
	@State var maxAnswer = 0
	@State var answer = 0
	@State var guess = ""
	@State var correct = false
	@State var hint = ""
	@State var level = 0

	var body: some View {
		VStack {
			Text("Level \(level)")
				.font(.largeTitle)
				.fontWeight(.thin)
				.foregroundColor(Color.gray)
				.padding(.bottom, 50.0)
			Text("I'm thinking of a number from \(minAnswer) to \(maxAnswer)")
				.padding(.bottom, 200.0)

			if correct {
				Button(action: startNewGame) {
					Text("Next").font(.system(size: 40)).bold()
					Image(systemName: "arrowshape.turn.up.right.fill").resizable().frame(width: 50, height: 30, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
				}
				AsyncImage(url: URL(string: "https://cataas.com/cat/says/hello?size=150&color=teal")!) { randomCat in
					randomCat
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(height: 200, alignment: .center)
				} placeholder: {
					ZStack(alignment: .bottom) {
						Image("FlyingCat")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(height: 200, alignment: .center)
						Text("More cats coming also cats crossing").foregroundColor(.white)
					}
				}
			} else {
				Text(hint).animation(.easeInOut)
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
		hint = ""
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			guard let guessNumber = Int(guess) else {
				hint = "number please tasty🍻"
				return
			}
			if answer == guessNumber {
				correct = true
				hint = ""
			} else if answer < guessNumber {
				hint = "Too high"
			} else if answer > guessNumber {
				hint = "Too low"
			}
		}
	}

	private func startNewGame() {
		level = level + 1

		if level % 3 == 1 {
			switch maxAnswer {
			case 0: maxAnswer = 10
			case 10: maxAnswer = 25
			case 400: maxAnswer = 1000
			case 1000: ()
			default: maxAnswer = maxAnswer * 2
			}
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
