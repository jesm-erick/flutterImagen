import 'package:app_upeu/apis/persona_api.dart';
import 'package:app_upeu/theme/AppTheme.dart';
import 'package:app_upeu/modelo/PersonaModel.dart';
import 'package:app_upeu/util/tokenUtil.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:provider/provider.dart';

class PersonaFormEdit extends StatefulWidget {
  PersonaModelo modelP;

  PersonaFormEdit({this.modelP}) : super();

  @override
  _PersonaFormEditState createState() => _PersonaFormEditState(modelP: modelP);
}

List<Map<String, String>> lista = [
  {'value': 'M', 'display': 'Masculino'},
  {'value': 'F', 'display': 'Femenino'}
];

class _PersonaFormEditState extends State<PersonaFormEdit> {
  String _dni;
  String _nombre;
  String ap_p;
  String _telefono;
  int _edad;
  String _fecha_nac;
  String _genero;
  var _data = [];

  PersonaModelo modelP;
  _PersonaFormEditState({this.modelP}) : super();

  @override
  void initState() {
    super.initState();
    _genero = modelP.genero;
    print("Llega ID: $modelP.id");

    print("ver data: ${modelP.nombre}");
    print("ver: ${lista.map((item) => item['value']).toList()}");
    print("verv: ${lista.map((item) => item['display']).toList()}");
  }

  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );

  Widget _buildDni() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'DNI:'),
      maxLength: 8,
      initialValue: modelP.dni,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'DNI Requerido!';
        }
        if (value.length != 8) {
          return 'DNI debe ser 8 digitos!';
        }
        return null;
      },
      onSaved: (String value) {
        _dni = value;
      },
    );
  }

  Widget _buildNombre() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nombre:'),
      keyboardType: TextInputType.text,
      initialValue: modelP.nombre,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onSaved: (String value) {
        _nombre = value;
      },
    );
  }

  Widget _buildAp_P() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Apellido Paterno:'),
      keyboardType: TextInputType.text,
      initialValue: modelP.ap_paterno,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Apellido paterno requerido!';
        }
        return null;
      },
      onSaved: (String value) {
        ap_p = value;
      },
    );
  }

  Widget _buildTelefono() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Num. Telefono:'),
      keyboardType: TextInputType.phone,
      initialValue: modelP.telefono,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Numero de Telefono Requerido';
        }
        return null;
      },
      onSaved: (String value) {
        _telefono = value;
      },
    );
  }

  Widget _buildGenero() {
    return DropDownFormField(
      titleText: 'Genero',
      hintText: 'Seleccione',
      value: _genero,
      onSaved: (value) {
        setState(() {
          _genero = value;
        });
      },
      onChanged: (value) {
        setState(() {
          _genero = value;
        });
      },
      dataSource: lista,
      textField: 'display',
      valueField: 'value',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Persona"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              color: AppTheme.nearlyWhite,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /*_buildName(),*/
                    _buildDni(),
                    _buildNombre(),
                    _buildAp_P(),
                    _buildTelefono(),
                    _buildGenero(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Cancelar')),
                          ElevatedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                                _formKey.currentState.save();
                                PersonaModelo mp = new PersonaModelo();
                                mp.nombre = _nombre;
                                mp.dni = _dni;
                                mp.telefono = _telefono;
                                mp.ap_paterno = ap_p;
                                //mp.edad = _edad;
                                //mp.fechaNac = _fecha_nac;
                                mp.genero = _genero;

                                print("IDX: $modelP.id");
                                var api = await Provider.of<PersonaApi>(context,
                                        listen: false)
                                    .updatePersona(
                                        TokenUtil.TOKEN, modelP.id.toInt(), mp);
                                print("ver: ${api.toJson()['mensaje']}");
                                if (api.toJson()['mensaje'] == "updated!!") {
                                  Navigator.pop(context, () {
                                    setState(() {});
                                  });
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No estan bien los datos de los campos!'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
