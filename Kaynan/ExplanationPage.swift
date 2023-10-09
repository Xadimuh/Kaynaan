import SwiftUI

struct ExplanationPage: View {
    @State private var isShowingLoginPage = false
    @ObservedObject var userData: UserData
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Image("logo") // Logo de l'application en haut de la page
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding(.leading, 17)
                

                VStack(alignment: .center) { // Nouveau VStack pour le contenu
                    Text("Bienvenue dans KAYNAAN")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 1)

                    // Texte explicatif avec des icônes et une image
                    HStack {
                        Image(systemName: "drop")
                            .font(.title)
                        Text("Restez hydraté")
                            .font(.headline)
                    }

                    HStack {
                        Image(systemName: "clock")
                            .font(.title)
                        Text("Suivez votre temps de sommeil")
                            .font(.headline)
                    }

                    HStack {
                        Image(systemName: "scale")
                            .font(.title)
                        Text("Gérez votre poids")
                            .font(.headline)
                    }

                    // Image d'illustration
                    Image("image2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)

                    // Texte descriptif
                    Text("KAYNAAN est une application qui vous aide à rester hydraté en suivant votre consommation d'eau, votre temps de sommeil, et en vous permettant de gérer votre poids. Commencez dès maintenant à prendre soin de votre santé !")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true) // Ajuste la hauteur en fonction du contenu

                    // Bouton pour rediriger vers la page de connexion
                    NavigationLink(
                       destination: SecondPage(userData: userData), // Assurez-vous d'avoir importé la vue LoginPage
                        isActive: $isShowingLoginPage,
                        label: {
                            Text("Start now")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(UIColor(red: 51/255, green: 73/255, blue: 92/255, alpha: 1.0)))
                                .cornerRadius(10)
                        }
                    )
                    .padding()
                }
                .padding(.leading, 0.0)
                .edgesIgnoringSafeArea(.all)

                 // Pousse le contenu vers le haut
            }
            .navigationBarHidden(true)
        }
        
        
    }
}


struct ExplanationPage_Previews: PreviewProvider {
    static var previews: some View {
        ExplanationPage(userData: UserData()) // Créez une instance de UserData ici
    }
}
