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
    //@FetchRequest(entity: URLString.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \URLString.string, ascending: true)])
    
    //var pictureList: FetchRequest<URLString>
    
    @State private var isShowingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination:
                                URLImage(URL(string: "https://i.ytimg.com/vi/jg8ixdQzrjc/maxresdefault.jpg")!) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }) {
                    URLImage(URL(string: "https://i.ytimg.com/vi/jg8ixdQzrjc/maxresdefault.jpg")!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            .navigationBarTitle("Изображеньки")
            .navigationBarItems(trailing: Button ("Добавить") {
                self.isShowingAddView.toggle()
            })
            .sheet(isPresented: $isShowingAddView) {
                AddPictureView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
}

struct PicturesListView_Previews: PreviewProvider {
    static var previews: some View {
        PicturesListView()
    }
}
