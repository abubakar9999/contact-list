class ContactModel {
  int? id;
  String name;
  String mobile;
  String? email;
  String? streetLocation;
  String? dob;
  String? img;
  String? gender;
  String? wibsite;
  ContactModel(
      {this.dob,
      this.email,
      this.gender,
      this.img,
      required this.mobile,
      required this.name,
      this.streetLocation,
      this.id,
      this.wibsite});
}

List<ContactModel> contactList = [
  ContactModel(
    id: 1,
    mobile: "01485236636",
    name: "abubakar",
    email: "mdabubakar@gmail.com",
    dob: "10-7-2002",
    gender: "mael",
    img: "assets/person.png",
    streetLocation: "Mirpur",
  ),
  ContactModel(
    id: 1,
    mobile: "017560746212",
    name: "Sakib",
    email: "sakaib@gmail.com",
    dob: "10-7-2002",
    gender: "mael",
    img: "assets/person.png",
    streetLocation: "Mirpur",
  ),
];
