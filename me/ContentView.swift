import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    @State var isJokeButtonON = false
    var body: some View {
        NavigationStack {
            PFPView()
            VStack {
                Text("Pat").font(.title).bold().fontDesign(.rounded)
                HStack {
                    Text("An 18 year old").font(.subheadline)
                    Button(action: { isJokeButtonON.toggle() }, label: {
                        Text("raccoon dog").strikethrough(pattern: .solid).font(.subheadline)
                    }).alert("For legal reasons only a human sadly", isPresented: $isJokeButtonON) {
                        Button("OK", role: .cancel, action: {})
                    }
                    Text("writing iPhone apps").font(.subheadline)
                }
            }.frame(maxWidth: .infinity).padding()

            VStack {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    NavigationLink(destination: ExperienceView(), label: { GroupBox {
                        VStack {
                            Image(systemName: "studentdesk")
                            Text("Experience")
                        }.frame(maxWidth: .infinity, maxHeight: .infinity).padding()
                    }})
                    NavigationLink(destination: ProjectsView(), label: { GroupBox {
                        VStack {
                            Image(systemName: "pencil.and.outline")
                            Text("Projects")
                        }.frame(maxWidth: .infinity, maxHeight: .infinity).padding()
                    }})
                    NavigationLink(destination: SocialsView(), label: { GroupBox {
                        VStack {
                            Image(systemName: "person.line.dotted.person.fill")
                            Text("Socials")
                        }.frame(maxWidth: .infinity, maxHeight: .infinity).padding()
                    }})
                    NavigationLink(destination: MyDevicesView(), label: { GroupBox {
                        VStack {
                            Image(systemName: "macbook.and.iphone")
                            Text("My everyday devices")
                        }.frame(maxWidth: .infinity, maxHeight: .infinity).padding()
                    }})
                }

            }.padding().frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview("Main") {
    ContentView()
}

@available(iOS 16.1, *)
struct PFPView: View {
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://parpok.xyz/content/avatar.png")) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView(label: { Text("Looking for pfp") })
            }.clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))

        }.padding(35)
    }
}

struct ExperienceView: View {
    var data: [ProgrammingExperience] = [
        ProgrammingExperience(name: "PHP", experience: 4),
        ProgrammingExperience(name: "Swift + SwiftUI", experience: 9),
        ProgrammingExperience(name: "Linux stuff", experience: 6),
        ProgrammingExperience(name: "MySQL", experience: 4),
        ProgrammingExperience(name: "Docker", experience: 3),
        ProgrammingExperience(name: "Git", experience: 6),
        ProgrammingExperience(name: "Kotlin(Android)", experience: 2),
        ProgrammingExperience(name: "C++", experience: 2),
        ProgrammingExperience(name: "JS/TS", experience: 5),
        ProgrammingExperience(name: "Astro.JS", experience: 5),
        ProgrammingExperience(name: "React + ReactNative", experience: 4),
    ]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(data) { stuff in
                        experienceView(name: stuff.name, amountOfExperience: Double(stuff.experience))
                    }
                }
                Section("This is what I think my experience is like. It's probably better in reality") {
                }
            }.listStyle(.automatic).navigationTitle("I'm familiar with")
        }
    }

    class ProgrammingExperience: Identifiable {
        var id = UUID()
        var name: String
        var experience: Int

        init(id: UUID = UUID(), name: String, experience: Int) {
            self.id = id
            self.name = name
            self.experience = experience
        }
    }
}

struct experienceView: View {
    @State var name: String
    @State var amountOfExperience: Double
    var body: some View {
        VStack {
            HStack {
                Text(name)
                Spacer()
                Text("\(amountOfExperience.formatted(.number)) / 10 ")
            }
            Gauge(value: amountOfExperience, in: 0 ... 10, label: {})
        }
    }
}

#Preview("Experience") {
    ExperienceView()
}

@available(iOS 16.1, *)
struct ProjectsView: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationStack {
            List {
                GroupBox {
                    Button {
                        openURL(URL(string: "https://github.com/parpok/meiPhone")!)
                    } label: {
                        VStack {
                            HStack {
                                VStack {
                                    Image(.thisApp).resizable().scaledToFit().padding()
                                }
                                VStack {
                                    Text("- Done in Swift/Xcode Playgrounds")
                                    Text("- Used to get back being used to to doing SwiftUI Layouts")
                                }
                            }
                            Text("This App").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }.padding().frame(maxWidth: .infinity, maxHeight: .infinity)

                GroupBox {
                    Button {
                        openURL(URL(string: "https://github.com/parpok/Ciastko-kliker")!)
                    } label: {
                        VStack {
                            Image(.cookieClick)
                                .resizable()
                                .scaledToFit()
                            Text("Very basic cookie-clicker style app using vanilla JS")
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)

                GroupBox {
                    Button {
                        openURL(URL(string: "https://github.com/parpok/PodstawowyKalkulatorVanillaJS")!)
                    } label: {
                        VStack {
                            Image(.calcVanilla)
                                .resizable()
                                .scaledToFit()
                            Text("Basic calculator made in vanilla JS")
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)

                GroupBox {
                    Button {
                        openURL(URL(string: "https://github.com/parpok/PodstawowyKalkulatorSvelte")!)
                    } label: {
                        VStack {
                            Image(.calcSvelte)
                                .resizable()
                                .scaledToFit()
                            Text("The same calculator but in Svelte")
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }.listStyle(.plain).navigationTitle("My Projects")
        }.fontDesign(.rounded)
    }
}

@available(iOS 16.1, *)
#Preview("Projects") {
    ProjectsView()
}

struct SocialsView: View {
    @Environment(\.openURL) private var openURL
    var body: some View {
        let accounts: [SNS] = [
            SNS(name: "My website", link: "https://parpok.xyz"),
            SNS(name: "Twitter/X", link: "https://twitter.com/Parpok206"),
            SNS(name: "Fedi(Serious)", link: "https://101010.pl/@parpok"),
            SNS(name: "Fedi(Chill)", link: "https://misskey.parpok.lomza.pl/@parpok"),
            SNS(name: "GitHub", link: "https://github.com/parpok"),
        ]

        NavigationStack {
            List {
                Section {
                    ForEach(accounts) { account in
                        Link(account.name, destination: URL(string: account.link)!)
                    }
                }
                Section {
                    Button(action: { openURL(URL(string: "mailto:me@parpok.xyz")!) }, label: {
                        Text("Email me")
                    })
                }
            }.navigationTitle("My Socials")
        }
    }

    private class SNS: Identifiable {
        var name: String
        var link: String
        init(name: String, link: String) {
            self.name = name
            self.link = link
        }
    }
}

#Preview("Socials") {
    SocialsView()
}

@available(iOS 17.0, *)
struct MyDevicesView: View {
    var body: some View {
        NavigationStack {
            List {
                GroupBox {
                    VStack {
                        Text("Phone").bold().font(.title).frame(maxWidth: .infinity, alignment: .topLeading)
                        VStack {
                            HStack {
                                Image(systemName: "iphone.gen2").font(.largeTitle)
                                Text("iPhone 13").font(.title2)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        HStack {
                            VStack {
                                Image(systemName: "memorychip.fill")
                                Text("Storage")
                            }
                            Text("128 GB Base model")
                        }.padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                GroupBox {
                    VStack {
                        Text("Laptop").bold().font(.title).frame(maxWidth: .infinity, alignment: .topLeading)
                        VStack {
                            HStack {
                                Image(systemName: "macbook.gen1").font(.largeTitle)
                                Text("MacBook Air M1 2020").font(.title2)
                            }.frame(maxWidth: .infinity, alignment: .topLeading)
                            HStack {
                                VStack {
                                    Image(systemName: "cpu")
                                    Text("CPU")
                                }.padding(1)
                                Text("Apple M1 8 Core + 7 Core GPU")
                            }.padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                VStack {
                                    Image(systemName: "memorychip")
                                    Text("RAM")
                                }.padding(1)
                                Text("16GB Version")
                            }.padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                VStack {
                                    Image(systemName: "memorychip.fill")
                                    Text("SSD")
                                }.padding(1)
                                Text("256 GB Stock SSD")
                            }.padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                }

                GroupBox {
                    VStack {
                        VStack {
                            Text("Desktop").bold().font(.title).frame(maxWidth: .infinity, alignment: .topLeading)
                        }
                        VStack {
                            HStack {
                                Image(systemName: "pc").font(.largeTitle)
                                Text("My custom build PC").font(.title2)
                            }.frame(maxWidth: .infinity, alignment: .topLeading)
                            VStack {
                                HStack {
                                    VStack {
                                        Image(systemName: "cpu")
                                        Text("CPU")
                                    }.padding(1)
                                    Text("AMD Ryzen 7 3700x (Overclocked to 4.05 GHz)")
                                }.padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
                                HStack {
                                    VStack {
                                        Image(systemName: "fan.fill")
                                        Text("Cooler")
                                    }.padding(1)
                                    Text("Stock AMD Wraith Prism")
                                }.padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
                                HStack {
                                    VStack {
                                        Image(systemName: "photo.artframe")
                                        Text("GPU")
                                    }.padding(1)
                                    Text("AMD Radeon 6700 XT 12GB")
                                }.padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
                                HStack {
                                    VStack {
                                        Image(systemName: "memorychip")
                                        Text("RAM")
                                    }.padding(1)
                                    Text("16GB(8*2) GoodRam DDR4 3200MHz (Overclocked to 3770MHz) ")
                                }.padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
                                HStack {
                                    VStack {
                                        Image(systemName: "memorychip.fill")
                                        Text("SSD")
                                    }.padding(1)
                                    Text("500 GB Kingston NVME PCIE 3.0 - System Storage")
                                }.padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
                                HStack {
                                    VStack {
                                        Image(systemName: "memorychip.fill")
                                        Text("SSD")
                                    }.padding(1)
                                    Text("1TB GoodRam NVME SSD PCIE 3.0 - Games + other")
                                }.padding(.leading).frame(maxWidth: .infinity, alignment: .leading)
                                HStack {
                                    VStack {
                                        Image(systemName: "window.vertical.closed")
                                        Text("OS")
                                    }.padding(1)
                                    Text("Windows 11")
                                }.padding(.horizontal).frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                }
                GroupBox {
                    VStack {
                        Text("'Smart'watch").bold().font(.title).frame(maxWidth: .infinity, alignment: .topLeading)
                        VStack {
                            HStack {
                                Image(systemName: "applewatch").font(.largeTitle)
                                Text("Apple Watch Series 3 42mm Space Gray GPS").font(.title2)
                            }
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                }
                GroupBox {
                    VStack {
                        Text("Earbuds").bold().font(.title).frame(maxWidth: .infinity, alignment: .topLeading)
                        VStack {
                            HStack {
                                Image(systemName: "beats.studiobuds.chargingcase").font(.largeTitle)
                                Text("Beats Studio Buds").font(.title2)
                            }
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                }
            }.listStyle(.plain).navigationTitle("My everyday devices").foregroundStyle(Color.accentColor)
        }
    }
}

@available(iOS 17.0, *)
#Preview("Devices") {
    MyDevicesView()
}
