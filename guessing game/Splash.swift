import AVFoundation
import SwiftUI

struct Splash: View {
	@Binding var hasGameStarted: Bool

	var body: some View {
		ZStack {
			Image("Splash").resizable().scaledToFit()
			VStack {
				Text("welcome to guessing game")
					.font(.largeTitle)
					.fontWeight(.heavy)
					.multilineTextAlignment(.center)
				Spacer()
				Button(action: { self.hasGameStarted = true; playStartSound() }) {
					Text("Play")
						.font(.largeTitle)
				}
			}
			.padding()
		}
	}
}

func playStartSound() {
	// List of sounds: http://iphonedevwiki.net/index.php/AudioServices
	let tiptoesSound = SystemSoundID(1334)
	AudioServicesPlayAlertSound(tiptoesSound)
}

struct Splash_Previews: PreviewProvider {
	static var previews: some View {
		Splash(hasGameStarted: .constant(false))
	}
}
