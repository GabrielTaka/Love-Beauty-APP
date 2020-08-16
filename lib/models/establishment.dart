
import 'package:Ubeleza/services/establishment_service.dart';

class Establishment {
  int id;
  String name;
  String slogan;
  String avatar;
  String cover;
  Details details;
  Address address;
  List<User> users;
  List<Product> products;
  List<Category> categories;

  Establishment({
    this.id,
    this.name,
    this.slogan,
    this.avatar,
    this.cover,
    this.details,
    this.address,
    this.users,
    this.products,
    this.categories
  });
  
  static Future<List<Establishment>> getList() async {
    dynamic establishments = await new EstablishmentService().getEstablishments(true);

    List<Establishment> tabIconsList = new List<Establishment>();

    establishments.forEach( (establishment) =>
      tabIconsList.add(
        Establishment(
          id: establishment['id'],
          name: establishment['name'],
          slogan: establishment['details']['slogan'],
          avatar: establishment['avatar'],
          cover: establishment['cover'],
          details: handleDetails(establishment),
          address: handleAddress(establishment),
          users: null,
          products: null,
          categories: null
        ),
      )
    );

    return tabIconsList;
  }

  static Future<List<Establishment>> getAllList() async {
    dynamic establishments = await new EstablishmentService().getEstablishments(false);

    List<Establishment> tabIconsList = new List<Establishment>();

    establishments.forEach( (establishment) =>
      tabIconsList.add(
        Establishment(
          id: establishment['id'],
          name: establishment['name'],
          slogan: establishment['details']['slogan'],
          avatar: establishment['avatar'],
          cover: establishment['cover'],
          details: handleDetails(establishment),
          address: handleAddress(establishment),
          users: null,
          products: null,
          categories: null
        ),
      )
    );

    return tabIconsList;
  }

  static Details handleDetails(establishment) {
    Details details = new Details();
    details.site = establishment["details"]['site'];
    details.email = establishment["details"]['email'];
    details.phone = establishment["details"]['phone'];
    details.twitter = establishment["details"]['twitter'];
    details.document = establishment["details"]['document'];
    details.facebook = establishment["details"]['facebook'];
    details.instagram = establishment["details"]['instagram'];
    details.description = establishment["details"]['description'];
    details.businessHours = establishment["details"]['business_hours'];

    return details;
  }

  static Address handleAddress(establishment) {
    
    Address address = new Address();
    address.cep = establishment['address']['cep'];
    address.city = establishment['address']['city'];
    address.neighborhood = establishment['address']['neighborhood'];
    address.street = establishment['address']['street'];
    address.number = establishment['address']['number'];
    address.complement = establishment['address']['complement'];
    address.uf = establishment['address']['uf'];
    address.district = establishment['address']['district'];
    address.state = establishment['address']['state'];
    address.long = establishment['address']['long'];
    address.lat = establishment['address']['lat'];

    return address;
  }
}


class Details {
  String site;
  String email;
  String phone;
  String twitter;
  String document;
  String facebook;
  String instagram;
  String description;
  String businessHours;
}

class Address {
  String cep;
  String city;
  String neighborhood;
  String street;
  String number;
  String complement;
  String uf;
  String district;
  String state;
  String establishmentId;
  String createdAt;
  String updatedAt;
  String long;
  String lat;
}

class User {
  int id;
  String email;
  String role;
  String name;
}

class Product {

}

class Category {

}