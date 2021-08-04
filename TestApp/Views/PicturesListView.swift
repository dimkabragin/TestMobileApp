//
//  PicturesList.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 04.08.2021.
//

import SwiftUI
import URLImage

struct PicturesListView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: URLString.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \URLString.string, ascending: true)]) var pictureList: FetchedResults<URLString>
    
    @State private var isShowingAddView = false
    
    var body: some View {
        List {
            ForEach (pictureList, id: \.self) { pic in
                NavigationLink(destination: ShowImageView(imageUrl: pic)) {
                    URLImage(URL(string: pic.string)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
        }
        .navigationBarTitle("Изображеньки")
        .navigationBarItems(
            leading: Button ("Выйти") {
                UserDefaults.standard.setValue(false, forKey: "isLogin")
                self.presentationMode.wrappedValue.dismiss()
        },
            trailing: Button ("Добавить") {
            self.isShowingAddView.toggle()
        })
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isShowingAddView) {
            AddPictureView().environment(\.managedObjectContext, self.moc)
        }
        
    }
}

struct PicturesListView_Previews: PreviewProvider {
    static var previews: some View {
        PicturesListView()
    }
}
