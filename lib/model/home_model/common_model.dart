

class CommonModel {
    bool hideAppBar;
    String icon;
    String statusBarColor;
    String title;
    String url;

    CommonModel({this.hideAppBar, this.icon, this.statusBarColor, this.title, this.url});

    factory CommonModel.fromJson(Map<String, dynamic> json) {
        return CommonModel(
            hideAppBar: json['hideAppBar'],
            icon: json['icon'],
            statusBarColor: json['statusBarColor'],
            title: json['title'],
            url: json['url'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['hideAppBar'] = this.hideAppBar;
        data['icon'] = this.icon;
        data['statusBarColor'] = this.statusBarColor;
        data['title'] = this.title;
        data['url'] = this.url;
        return data;
    }
}