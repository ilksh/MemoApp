import SwiftUI

struct MainListVIew: View {
    @EnvironmentObject var store : MemoStore
    
    @State private var showComposer: Bool = false
    
    var body: some View {
         NavigationView {
             List {
                 ForEach(store.list) { memo in
                    NavigationLink {
                        DetailView(memo: memo)
                    } label: {
                        MemoCell(memo: memo)
                    }
                }
                 .onDelete(perform: store.delete)
            }
             .listStyle(.plain)
             .navigationTitle("Aaron's memo")
             .toolbar {
                 Button{
                     showComposer = true
                 } label: {
                     Image(systemName: "plus")
                 }
             }
             .sheet(isPresented: $showComposer) {
                 ComposeView()
        }
        
    }
}

struct MainListVIew_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainListVIew()
                .environmentObject(MemoStore())
            .previewInterfaceOrientation(.portrait)
            MainListVIew()
                .environmentObject(MemoStore())
                .previewInterfaceOrientation(.portrait)
        }
    }
}
}


