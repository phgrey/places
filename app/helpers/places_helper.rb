module PlacesHelper
  def self.get_city_on_map(city,lang)
    cities =
      {
        lutsk: {ru: "lutsk" ,en: "luts-k",uk: "lutsk--2"},uzhhorod: {ru: "uzhgorod" ,en: "uzhhorod",uk: "uzhgorod--2"},
        cherkasy: {ru: "cherkassy" ,en: "cherkasy",uk: "cherkasi"},chernihiv: {ru: "chernigov" ,en: "chernihiv",uk: "chernigiv"},
        chernivtsi: {ru: "chernovtsy" ,en: "chernivtsi",uk: "chernivtsi--2"},dnepropetrovsk: {ru: "dnepropetrovsk" ,en: "dnipropetrovs-k",uk: "dnipropetrovsk"},
        donetsk: {ru: "donetsk" ,en: "donets-k",uk: "donetsk--2"}, ivano_frankivsk:{ru: "ivano-frankovsk" ,en: "ivano-frankivs-k",uk: "ivano-frankivsk"},
        kharkiv: {ru: "harkov" ,en: "kharkiv",uk: "harkiv"}, kherson: {ru: "herson" ,en: "kherson",uk: "herson--2"},
        khmelnytskyi: {ru: "hmelnitskiy" ,en: "khmel-nyts-kyi",uk: "hmelnitskiy--2"}, kirovohrad: {ru: "kirovograd" ,en: "kirovohrad",uk: "kirovograd--2"},
        krym: {ru: "simferopol" ,en: "simferopol--2",uk: "simferopol--3"}, kuiv: {ru: "kiev" ,en: "kyiv",uk: "kiyiv"},
        luhansk: {ru: "lugansk" ,en: "luhans-k",uk: "lugansk--2"}, lviv: {ru: "lvov" ,en: "l-viv",uk: "lviv"},
        mukolaev: {ru: "nikolaev" ,en: "mykolaiv",uk: "mikolayiv"}, odessa: {ru: "odessa" ,en: "odessa--2",uk: "odesa"},
        poltava: {ru: "poltava" ,en: "poltava--2",uk: "poltava--3"}, rivno: {ru: "rovno" ,en: "rivne",uk: "rivne--2"},
        symskay: {ru: "sumy" ,en: "sumy--2",uk: "sumi"}, ternopil: {ru: "ternopol" ,en: "ternopil",uk: "ternopil--2	"},
        vinitskay: {ru: "vinnitsa" ,en: "vinnytsia",uk: "vinnitsya"}, zaporozhskay: {ru: "zaporozhie" ,en: "zaporizhzhia",uk: "zaporizhzhya"},
        zhytomerskay: {ru: "zhitomir" ,en: "zhytomyr",uk: "zhitomir--2"}
     }
    return cities[city.to_sym][lang.to_sym]
  end
end
