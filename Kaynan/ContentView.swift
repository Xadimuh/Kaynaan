import SwiftUI

struct ContentView: View {
    @State private var isShowingExplanationPage = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Image("logo") // Logo de l'application en haut de la page
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding(.leading, 17)
                
                VStack(alignment: .center) {
                
                    Text("STAY HYDRATED WITH KAYNAAN")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.top, .leading], 3)
                        .frame(width: 400.0)

                    // Texte en bas de l'image
                    Text("Remember to drink water regularlyto stay \n hydrated and healthy.\n")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding([.top, .bottom, .trailing])
                        .frame(width: 800.0)

                    // Espacement depuis le bas de l'image

                    // Image d'arrière-plan
                    Image("image1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 400)

                    // Bouton de démarrage avec navigation vers la page d'explication
                    NavigationLink(
                        destination: ExplanationPage(),
                        isActive: $isShowingExplanationPage,
                        label: {
                            HStack {
                                Text("Let's start")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color(UIColor(red: 51/255, green: 73/255, blue: 92/255, alpha: 1.0))) // Couleur personnalisée en RGB
                                    .cornerRadius(20)

                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                    )
                    .padding()
                }
                .padding(.leading, 0.0)
                .edgesIgnoringSafeArea(.all)
            }
            .navigationBarHidden(true) // Masquer la barre de navigation
        }
       
        
    }
}

// ... (extension Color et ContentView_Previews restent inchangés)

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
