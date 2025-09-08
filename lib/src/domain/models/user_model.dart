import 'package:subeya/src/domain/models/rol_model.dart';

class User {
    int ?id;
    String ?name;
    String ?lastname;
    String ?email;
    String ?phone;
    dynamic ?image;
    dynamic ?notificationToken;
    List<Role> ?roles;

    User({
        this.id,
        this.name,
        this.lastname,
        this.email,
        this.phone,
        this.image,
        this.notificationToken,
        this.roles,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
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
        "image": image,
        "notification_token": notificationToken,
        "roles": roles!=null?  List<dynamic>.from(roles!.map((x) => x.toJson())): [],
    };
}

