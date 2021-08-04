//
//  ShowImageView.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 04.08.2021.
//

import SwiftUI
import URLImage
import CoreData

struct ShowImageView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var imageUrl: URLString
    var body: some View {
        URLImage(URL(string: imageUrl.string) ?? URL(string: "https://pbs.twimg.com/media/Er_eAPzW4AEHLRR.png")!) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .navigationBarItems(trailing: Button ("Удалить") {
            moc.delete(imageUrl)
            try? moc.save()
            self.presentationMode.wrappedValue.dismiss()
        })
    }
}

//struct ShowImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowImageView()
//    }
//}
