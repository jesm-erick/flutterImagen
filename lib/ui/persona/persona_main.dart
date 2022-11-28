import 'package:app_upeu/apis/persona_api.dart';
import 'package:app_upeu/comp/TabItem.dart';
import 'package:app_upeu/ui/persona/persona_edit.dart';
import 'package:app_upeu/ui/persona/persona_form.dart';
import 'package:app_upeu/util/tokenUtil.dart';
//import 'package:app_upeu/ui/persona/beneficiario_edit.dart';
//import 'package:app_upeu/ui/persona/beneficiario_form.dart';
import 'package:flutter/material.dart';
import 'package:app_upeu/modelo/PersonaModel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:app_upeu/theme/AppTheme.dart';

import '../help_screen.dart';

class MainPersona extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<PersonaApi>(
      create: (_) => PersonaApi.create(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
        theme: AppTheme.themeData,
        //theme: ThemeData(primaryColor: Colors.lightBlue),
        home: PersonaUI(),
      ),
    );
  }
}

class PersonaUI extends StatefulWidget {
  @override
  _PersonaUIState createState() => _PersonaUIState();
}

final tabs = ['Home', 'Profile', 'Help', 'Settings'];

class _PersonaUIState extends State<PersonaUI> {
//ApiCovid apiService;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var api;
  @override
  void initState() {
    super.initState();
//apiService = ApiCovid();
//api=Provider.of<PredictionApi>(context, listen: false).getPrediction();
    print("entro aqui");
  }

  Future onGoBack(dynamic value) {
    setState(() {
      print(value);
    });
  }

  void accion() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData,
      home: Scaffold(
        appBar: new AppBar(
          title: Text(
            'Lista de Personas',
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("Si funciona");
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  //final producto=new ModeloProductos();
                  //formDialog(context, producto);
                  print("Si funciona 2");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonaForm()),
                  ).then(onGoBack);
                },
                child: Icon(Icons.add_box_sharp),
              ),
            )
          ],
        ),

        //backgroundColor: AppTheme.nearlyWhite,
        body: FutureBuilder<List<PersonaModelo>>(
          future: Provider.of<PersonaApi>(context, listen: true)
              .getPersona()
              .then((value) => value.data),
          builder: (BuildContext context,
              AsyncSnapshot<List<PersonaModelo>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<PersonaModelo> persona = snapshot.data;
              print(persona.length);
              return _buildListView(persona);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        bottomNavigationBar: _buildBottomTab(),
      ),
    );
  }

  Widget _buildListView(List<PersonaModelo> persona) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          PersonaModelo personax = persona[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                        title: Text(personax.nombre,
                            style: Theme.of(context).textTheme.headline6),
                        subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.redAccent),
                                child: Text(
                                  personax.dni,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.yellow),
                                child: Text(
                                  personax.genero.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ]),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png")),
                        trailing: Row(mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.edit),
                                  color: AppTheme.themeData.colorScheme.primary,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PersonaFormEdit(
                                              modelP: personax)),
                                    ).then(onGoBack);
                                  }),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text("Mensaje de confirmacion"),
                                            content: Text("Desea Eliminar?"),
                                            actions: [
                                              FloatingActionButton(
                                                child: const Text('CANCEL'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop('Failure');
                                                },
                                              ),
                                              FloatingActionButton(
                                                  child: const Text('ACCEPT'),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('Success');
                                                  })
                                            ],
                                          );
                                        }).then((value) {
                                      if (value.toString() == "Success") {
                                        print(personax.id);

                                        Provider.of<PersonaApi>(context,
                                                listen: false)
                                            .deletePersona(personax.id)
                                            .then((value) => onGoBack(value));
                                        //var onGoBack = onGoBack;
                                        //BlocProvider.of<ProductosBloc>(context).add(DeleteProductoEvent(producto: state.productosList[index]));

                                      }
                                    });
                                  })
                            ])),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: persona.length,
      ),
    );
  }

  int selectedPosition = 0;
  _buildBottomTab() {
    return BottomAppBar(
      color: Colors.deepPurple,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem(
            text: tabs[0],
            icon: Icons.home,
            isSelected: selectedPosition == 0,
            onTap: () {
              setState(() {
                selectedPosition = 0;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HelpScreen();
              }));
            },
          ),
          TabItem(
            text: tabs[1],
            icon: Icons.person,
            isSelected: selectedPosition == 1,
            onTap: () {
              setState(() {
                selectedPosition = 1;
              });
            },
          ),
          SizedBox(
            width: 48,
          ),
          TabItem(
            text: tabs[2],
            icon: Icons.help,
            isSelected: selectedPosition == 2,
            onTap: () {
              setState(() {
                selectedPosition = 2;
              });
            },
          ),
          TabItem(
            text: tabs[3],
            icon: Icons.settings,
            isSelected: selectedPosition == 3,
            onTap: () {
              setState(() {
                selectedPosition = 3;
              });
            },
          ),
        ],
      ),
    );
  }
}
