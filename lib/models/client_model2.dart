class ClientModel {
  final int? id;
  final String numCompte;
  final String nom;
  final String dateNaissance;
  final String mobile;
  final String langue;
  final int? idAgence;
  final String sexe;
  final int idUser;
  final String profession;
  final String photoCNI_recto;
  final String photoCNI_verso;
  final String cni;
  final String dateDelivrance;
  final int idZone;
  final String photoClient;
  




  ClientModel(
      {
        required this.id,
      required this.numCompte,
      required this.nom,
      required this.sexe,
      required this.mobile,
      required this.idUser,
      required this.idZone,
      required this.profession,
      required this.cni,
      required this.dateDelivrance,
      required this.photoClient,
      required this.photoCNI_recto,
      required this.photoCNI_verso,
      required this.dateNaissance,
      required this.langue,
      required this.idAgence,});

  // data from json
  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
      id: int.parse(json["id"]),
      numCompte: json["numCompte"],
      nom: json["nom"],
      sexe:json['sexe'],
      mobile:json['mobile'],
      idUser:int.parse(json['idUser']),
      idZone:int.parse(json['idZone']),
      profession:json['profession'],
      cni:json['cni'],
      dateDelivrance:json['dateDelivrance'],
      photoClient:json['photoClient'],
      photoCNI_recto:json['photoCNI_recto'],
      photoCNI_verso:json['photoCNI_verso'],
      dateNaissance: json["dateNaissance"],
      langue: json["langue"],
      idAgence: int.tryParse(json["idAgence"]) ?? 0,);
}
