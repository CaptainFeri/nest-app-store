class App {
  final i;
  final id;
  final trackName;
  final sizeBytes;
  final currency;
  final price;
  final ratingCountTot;
  final ver;
  final contRating;
  final primeGenre;
  final langnum;
  final vppLic;
  final createddate;
  final updateddate;
  final deleteddate;

  App({
    this.i,
    this.id,
    this.trackName,
    this.sizeBytes,
    this.currency,
    this.price,
    this.ratingCountTot,
    this.ver,
    this.contRating,
    this.primeGenre,
    this.langnum,
    this.vppLic,
    this.createddate,
    this.updateddate,
    this.deleteddate,
  });

  factory App.fromJson(Map<String, dynamic> json) {
    return App(
        i: json["i"],
        id: json["id"],
        trackName: json["track_name"],
        sizeBytes: json["size_bytes"],
        currency: json["currency"],
        price: json["price"],
        ratingCountTot: json["rating_count_tot"],
        ver: json["ver"],
        contRating: json["cont_rating"],
        primeGenre: json["prime_genre"],
        langnum: json["langnum"],
        vppLic: json["vpp_lic"],
        createddate: json["createddate"],
        updateddate: json["updateddate"],
        deleteddate: json["deleteddate"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['i'] = this.i;
    data['id'] = this.id;
    data['track_name'] = this.trackName;
    data['size_bytes'] = this.sizeBytes;
    data['currency'] = this.currency;
    data['price'] = this.price;
    data['rating_count_tot'] = this.ratingCountTot;
    data['ver'] = this.ver;
    data['cont_rating'] = this.contRating;
    data['prime_genre'] = this.primeGenre;
    data['langnum'] = this.langnum;
    data['vpp_lic'] = this.vppLic;
    data['createddate'] = this.createddate;
    data['updateddate'] = this.updateddate;
    data['deleteddate'] = this.deleteddate;
    return data;
  }
}
