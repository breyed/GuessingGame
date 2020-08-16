import SwiftUI

struct Main: View {
	@State var hasGameStarted = false

	var body: some View {
		Group {
			if hasGameStarted {
				Game()
			} else{
				Splash(hasGameStarted: $hasGameStarted)
			}
		}
	}
}

struct Main_Previews: PreviewProvider {
	static var previews: some View {
		Main()
	}
}
