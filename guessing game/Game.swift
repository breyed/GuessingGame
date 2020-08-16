import AVFoundation
import SwiftUI

struct Game: View {
	@State var guess: String = ""

	var body: some View {
		VStack {
			Text("I'm thinking of a number from 1 to 10")
				.padding(.bottom, 300.0)
			HStack {
				TextField("Guess", text: $guess)
					.padding(.bottom, 200.0)
					.frame(width: 100)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.keyboardType(.numberPad)
				Button(action: {}) { Text("Enter")
					.padding(.bottom, 200.0)
				}
			}
		}
		.padding(.all)
	}
}

struct Game_Previews: PreviewProvider {
	static var previews: some View {
		Game()
	}
}
