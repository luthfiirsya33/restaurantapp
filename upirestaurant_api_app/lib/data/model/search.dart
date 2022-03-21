import 'dart:convert';

Searchrestaurant searchrestaurantFromJson(String str) => Searchrestaurant.fromJson(json.decode(str));

String searchrestaurantToJson(Searchrestaurant data) => json.encode(data.toJson());

class Searchrestaurant {
    Searchrestaurant({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    bool error;
    int founded;
    List<SearchRestaurant> restaurants;

    factory Searchrestaurant.fromJson(Map<String, dynamic> json) => Searchrestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<SearchRestaurant>.from(json["restaurants"].map((x) => SearchRestaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class SearchRestaurant {
    SearchRestaurant({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    String id;
    String name;
    String description;
    String pictureId;
    String city;
    double rating;

    factory SearchRestaurant.fromJson(Map<String, dynamic> json) => SearchRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
    };
}
