class SearchModel {
    String keyword;
    final List<SearchModelItem> data;

    SearchModel({this.data});

    factory SearchModel.fromJson(Map<String, dynamic> json) {
        return SearchModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => SearchModelItem.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class SearchModelItem {
    final String code;
    final String districtname;
    final String price;
    final String type;
    final String url;
    final String word;

    SearchModelItem({this.code, this.districtname, this.price, this.type, this.url, this.word});

    factory SearchModelItem.fromJson(Map<String, dynamic> json) {
        return SearchModelItem(
            code: json['code'],
            districtname: json['districtname'],
            price: json['price'],
            type: json['type'],
            url: json['url'],
            word: json['word'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['districtname'] = this.districtname;
        data['price'] = this.price;
        data['type'] = this.type;
        data['url'] = this.url;
        data['word'] = this.word;
        return data;
    }
}