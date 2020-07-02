class UserListResponseModel {
  List<UserList> userList;

  UserListResponseModel({this.userList});

  UserListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['userList'] != null) {
      userList = new List<UserList>();
      json['userList'].forEach((v) {
        userList.add(new UserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userList != null) {
      data['userList'] = this.userList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserList {
  String username;
  String password;

  UserList({this.username, this.password});

  UserList.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
