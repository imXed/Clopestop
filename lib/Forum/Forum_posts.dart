import 'package:flutter/material.dart';

import '../consts.dart';

class Post extends StatefulWidget {
  int post;
  Post({Key? key, required this.post}) : super(key: key);

  @override
  State<Post> createState() => _PostState(post1: post);
}

class _PostState extends State<Post> {
  bool? vis;
  int? post1;
  String? name;
  String? date;
  String? title;
  String? description;
  String? comment1;
  String? comment2;
  String? personne1;
  String? personne2;
  _PostState({this.post1});
  String user1 = 'assets/icons/user1.png';
  String user2 = 'assets/icons/user2.png';
  String user3 = 'assets/icons/user3.png';
  String? img;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (post1 == 1) {
      vis = true;
      img = user1;
      personne1 = 'Kader Terigou';
      personne2 = 'Achref Taha';
      name = 'Ferkous Imed Eddine ';
      date = '2 days ago';
      title = 'Comment s’occuper quand on arrête \nde fumer ?';
      description =
          'Je cherche deseperement un moyen de\nremplacer mes cigarettes.\nQue me proposez-vous';
      comment1 =
          'a chaque fois que jai envie de fumer j\'ecoute de la music et je respire profondement, tu devrais essayer c\'est tres efficace a mon avis.';
      comment2 =
          'Pour moi c\'etait les jeux video qui m\'ont permis d\'oublier un peu.';
    } else if (post1 == 2) {
      vis = true;
      img = user2;

      personne1 = 'Said Mohamed';
      personne2 = 'Cherif Sid';
      name = 'Sami Selami';
      date = '4 days ago';
      title = 'Tous apres arret de fumer';
      description =
          'j\'ai arreter totalement de fumer depuis \n1 mois et pourtant je tousse beacoup et je \nsuis tres essouflee , est-ce que c\'est normale \n pour une ancienne petite fumeuse comme \nmoi ?  ';
      comment1 =
          'c\' le meme cas pour moi j\'espere trouver une reponse assurante';
      comment2 =
          'je suis dans votre situation et je me suis renseigner chez le tabacologue du coin, il m\'a dit que c\'est tout a fait normal vu l\'effet de la cigarette a long terme. ';
    } else {
      vis = false;
      img = user3;

      personne1 = 'Hadi Amir';
      personne2 = 'Chelfi Oussama';
      name = 'Hamdane Ala';
      date = '1 week ago';
      title = 'Arret de tabac depuis 4 mois ';
      description =
          'j\'ai arreter de fumer du jour au lendemain\nsans patch ni chewing-gum. Les premieres\nsemaine etaient tres difficiles mais j\'ai tenu \nle coup.\nCourage ! vous pouvez aussi le faire.';
      comment1 =
          'toutes mes felicitaions ! j\'y suis presque je ne consomme plus qu\'une cigarette par jour ';
      comment2 = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPrimaryColor,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    img!,
                    scale: 0.6,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name!),
                      Text(date!),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(title!,
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(description!,
                      style: const TextStyle(
                        fontSize: 18,
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: KPrimaryColor,
                thickness: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(personne1!),
                          ],
                        ),
                      ],
                    ),
                    Text(comment1!),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Visibility(
                visible: vis!,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(personne2!),
                            ],
                          ),
                        ],
                      ),
                      Text(comment2!),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 167,
              ),
              TextFormField(
                decoration: (const InputDecoration(
                  hintText: 'Ajouter un commentaire',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: KPrimaryColor,
                    ),
                  ),
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
