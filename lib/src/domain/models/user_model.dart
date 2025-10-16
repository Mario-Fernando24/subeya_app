import 'package:subeya/src/domain/models/rol_model.dart';
//https://app.quicktype.io/
class User {
    int ?id;
    String name;
    String lastname;
    String ?email;
    String phone;
    String ?password;
    dynamic ?image;
    dynamic ?notificationToken;
    List<Role> ?roles;

    User({
        this.id,
        required this.name,
        required this.lastname,
        this.email,
        required this.phone,
        this.image,
        this.password,
        this.notificationToken,
        this.roles,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"] ?? '',
        lastname: json["lastname"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        password: json["password"],
        image: json["image"],
        notificationToken: json["notification_token"],
        // valida si roles no es null antes de mapear
        roles: json["roles"]!=null? List<Role>.from(json["roles"].map((x) => Role.fromJson(x))):[],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "password": password,
        "image": image,
        "notification_token": notificationToken,
        "roles": roles!=null?  List<dynamic>.from(roles!.map((x) => x.toJson())): [],
    };
}

