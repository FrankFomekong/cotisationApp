class ClientModel {
  final int? id;
  final String nom;
  final String dateNaissance;
  final String lieuNaissance;
  final String mobile;
  final String langue;
  final int? idAgence;
  final String sexe;
  final int idUser;
  final int idZone;
  




  ClientModel(
      {
       this.id,
      required this.nom,
      required this.sexe,
      required this.mobile,
      required this.idUser,
      required this.idZone,
      required this.dateNaissance,
      required this.langue,
      required this.lieuNaissance,
      required this.idAgence,});

  // data from json
  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
      id: int.parse(json["id"]),
      nom: json["nom"],
      sexe:json['sexe'],
      mobile:json['mobile'],
      idUser:int.parse(json['idUser']),
      idZone:int.parse(json['idZone']),
      dateNaissance: json["dateNaissance"],
      langue: json["langue"],
      lieuNaissance:json['lieuNaissance'],
      idAgence: int.tryParse(json["idAgence"]) ?? 0,);
}
