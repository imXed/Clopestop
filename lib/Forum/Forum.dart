import 'package:clopestop/Forum/Forum_posts.dart';
import 'package:clopestop/consts.dart';
import 'package:flutter/material.dart';

class Forum extends StatelessWidget {
  const Forum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: KPrimaryColor,
          title: const Text('Forum'),
          centerTitle: true,
        ),
        body: Container(
          color: const Color.fromARGB(179, 217, 217, 217),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Post(post: 1)),
                  );
                },
                child: Column(
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
                          'assets/icons/user1.png',
                          scale: 0.6,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Ferkous Imed Eddine'),
                            Text('2 days ago'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text('Comment s’occuper quand on arrête\nde fumer ?',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                            'Je cherche désespérément un moyen de\nremplacer mes cigarettes.\nQue me proposez vous',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(171, 187, 178, 178),
                      thickness: 1,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 30,
                        ),
                        Text('2 Commentaires'),
                        SizedBox(
                          width: 185,
                        ),
                        Icon(
                          Icons.insert_comment,
                          color: KPrimaryColor,
                          size: 35,
                        )
                      ],
                    ),
                    const Divider(
                      color: KPrimaryColor,
                      thickness: 5,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Post(post: 2)),
                  );
                },
                child: Column(
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
                          'assets/icons/user2.png',
                          scale: 0.6,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Sami Selami'),
                            Text('4 days ago'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text('Toux après arrêt de tabac',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                            'J’ai arrêté totalement de fumer depuis\n1 mois et pourtant je tousse beaucoup et je \nsuis très essoufflé ... ',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(171, 187, 178, 178),
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 20,
                          ),
                          Text('2 Commentaires'),
                          SizedBox(
                            width: 185,
                          ),
                          Icon(
                            Icons.insert_comment,
                            color: KPrimaryColor,
                            size: 35,
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: KPrimaryColor,
                      thickness: 5,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Post(post: 3)),
                  );
                },
                child: Column(
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
                          'assets/icons/user3.png',
                          scale: 0.6,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Hamdane Ala'),
                            Text('1 week ago'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text('Arret de tabac depuis 4 mois ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                            'j\'ai arrêter de fumer du jour au lendemain\nsans patch ni chewing-gum...  ',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(171, 187, 178, 178),
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 20,
                          ),
                          Text('1 Commentaires'),
                          SizedBox(
                            width: 185,
                          ),
                          Icon(
                            Icons.insert_comment,
                            color: KPrimaryColor,
                            size: 35,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
