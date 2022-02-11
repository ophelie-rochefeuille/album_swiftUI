
import SwiftUI

struct ConcertView: View {
    @EnvironmentObject var model: ViewModel
    let concert: Concert
    
    var body: some View {
        VStack{
            Text("\(concert.name ?? "Nom de l'artiste")").padding()
            Text("\(concert.Lieu ?? "Lieu")").padding()
            Text("\(concert.Date ?? "Date")").padding()
            Text("\(concert.Description ?? "Description")").padding()
    }
}


}
