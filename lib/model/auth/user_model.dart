class UserModel {
  List<Authorities>? authorities;
  String? username;
  int? id;
  bool? enabled;
  bool? accountNonExpired;
  bool? accountNonLocked;
  bool? credentialsNonExpired;

  UserModel(
      {this.authorities,
      this.username,
      this.id,
      this.enabled,
      this.accountNonExpired,
      this.accountNonLocked,
      this.credentialsNonExpired});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['authorities'] != null) {
      authorities = <Authorities>[];
      json['authorities'].forEach((v) {
        authorities!.add(new Authorities.fromJson(v));
      });
    }
    username = json['username'];
    id = json['id'];
    enabled = json['enabled'];
    accountNonExpired = json['accountNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    credentialsNonExpired = json['credentialsNonExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.authorities != null) {
      data['authorities'] = this.authorities!.map((v) => v.toJson()).toList();
    }
    data['username'] = this.username;
    data['id'] = this.id;
    data['enabled'] = this.enabled;
    data['accountNonExpired'] = this.accountNonExpired;
    data['accountNonLocked'] = this.accountNonLocked;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    return data;
  }
}

class Authorities {
  String? authority;

  Authorities({this.authority});

  Authorities.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authority'] = this.authority;
    return data;
  }
}
