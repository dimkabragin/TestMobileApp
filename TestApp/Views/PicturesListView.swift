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
                    URLImage(URL(string: pic.string) ?? URL(string: "https://pbs.twimg.com/media/Er_eAPzW4AEHLRR.png")!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .frame(height: 200)
                .onAppear {
                    if pictureList.count < 4 || pic == pictureList[pictureList.count-1]  {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            getImages()
                        }
                    }
                }
            }
        }
        .onAppear {
            if pictureList.count < 4 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    getImages()
                }
            }
        }
        .navigationBarTitle("Изображеньки (\(pictureList.count))")
        .navigationBarItems(
            leading: Button ("Выйти") {
                UserDefaults.standard.setValue(false, forKey: "isLogin")
                for pic in pictureList {
                    moc.delete(pic)
                    try? moc.save()
                }
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
    
    // Получаем изображеньки с сервера
    private func getImages() {
        for _ in 0..<10 {
            let urlString = URLString(context: self.moc)
            urlString.string = "https://via.placeholder.com/1920x1080/\(randomColorCode())/\(randomColorCode())/cat.jpg"
            try? self.moc.save()
        }
    }
    
    // Делаем рандомные цвета
    private func randomColorCode() -> String {
        let rnd = Int.random(in: 0..<65535)
        let str = String(format: "%06X", rnd)
        return str;
    }
}

struct PicturesListView_Previews: PreviewProvider {
    static var previews: some View {
        PicturesListView()
    }
}
