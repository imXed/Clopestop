import 'package:clopestop/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'goals_model.dart';

class GoalView extends StatefulWidget {
  Goal? goal;
  GoalView({Key? key, this.goal}) : super(key: key);

  @override
  _GoalViewState createState() => _GoalViewState(goal: goal);
}

class _GoalViewState extends State<GoalView> {
  Goal? goal;
  _GoalViewState({this.goal});
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (goal != null) {
      titleController.text = goal!.title!;
      priceController.text = goal!.price!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        backgroundColor: KPrimaryColor,
        title: const Text("Ajouter un Objectif"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  child: colorOverride(TextField(
                onChanged: (data) {
                  goal?.title = data;
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.white),
                  labelText: "Objectif",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
                controller: titleController,
              ))),
              const SizedBox(
                height: 25,
              ),
              Container(
                child: colorOverride(
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (data) {
                      goal?.price = data;
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      labelText: "prix",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                    controller: priceController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 55.0,
        child: BottomAppBar(
            color: KPrimaryColor,
            child: IconButton(
              icon: const Icon(Icons.save, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, goal);
              },
            )),
      ),
    );
  }

  Widget colorOverride(Widget child) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
        hintColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      child: child,
    );
  }
}
