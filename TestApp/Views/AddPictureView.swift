//
//  AddPictureView.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 04.08.2021.
//

import SwiftUI
import URLImage

struct AddPictureView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State var url = ""
    
    var body: some View {
        Form {
            Section {
                TextField ("Введите URL картинки", text: $url)
                URLImage((URL(string: url) ?? URL(string: "https://pbs.twimg.com/media/Er_eAPzW4AEHLRR.png"))!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            Button ("Добавить картинку") {
                if (url != "") //Добавить обработку корректности загрузки
                {
                    let urlString = URLString(context: self.moc)
                    urlString.string = self.url
                    do {
                        try self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print ("ойой \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
