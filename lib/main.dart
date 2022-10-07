import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<String> salaryList = <String>[
  'Abaixo de 1 salário mínimo(abaixo de R\$ 1212,00)',
  'Entre 2 salários mínimos(R\$ 2424,00) e 1 salário mínimo(R\$ 1212,00)',
  'Acima de 2 salários mínimos'
];

const List<String> childrenList = <String>[
  'Nenhum filho matriculado e vacinado',
  'Um filho matriculado e vacinado',
  "Dois filhos matriculados e vacinados",
  "Três filhos matriculados e vacinados",
  "Mais de três filhos matriculados e vacinados"
];

const List<Widget> choiceList = <Widget>[
  Text('Sim'),
  Text('Não'),
];

void main(){

  runApp(const MaterialApp(
    title: 'Prova 1',
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  String _salaryDropdownValue = salaryList.first;
  int _salaryIndex = 0;
  String _childrenDropdownValue = childrenList.first;
  int _childrenIndex = 0;
  List<bool> _selectedFatherChoiceList = <bool>[false, false];
  int fatherIndex = -1;
  List<bool> _selectedMotherChoiceList = <bool>[false, false];
  int motherIndex = -1;
  String _message = "";
  bool vertical = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    setState(() {
      _salaryDropdownValue = salaryList.first;
      _salaryIndex = 0;
      _childrenDropdownValue = childrenList.first;
      _childrenIndex = 0;
      _selectedFatherChoiceList = <bool>[false, false];
      fatherIndex = -1;
      _selectedMotherChoiceList = <bool>[false, false];
      motherIndex = -1;
      _message = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculateAssistance(int salaryIndex, int childrenIndex, int fatherIndex, int motherIndex){
    setState(() {
      if(childrenIndex == 0 || childrenIndex == 1 || salaryIndex == 2){
        _message = "Você não possui direito ao auxílio!";
      }else{
        if(childrenIndex == 2 && salaryIndex == 0){
          _message = "Você tem direito a 2,5 salários mínimos";
        }else if(childrenIndex == 2 && salaryIndex == 1){
          _message = "Você tem direito a 1,5 salários mínimos";
        }else if(childrenIndex == 3 || childrenIndex == 4){
          if(salaryIndex == 0 || salaryIndex == 1){
            _message = "Você tem direito a 3 salários mínimos";
          }
        }
      }

      if(fatherIndex == 0){
        if(motherIndex == 1 && childrenIndex >= 1){
          if(_message == "Você não possui direito ao auxílio!"){
            _message = "Você tem direito a um bônus de R\$600.00!";
          }else {
            _message += " e a um bônus de R\$600.00!";
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Prova 1"),
        centerTitle: true,
        backgroundColor: Colors.white12,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.refresh), onPressed: _resetFields,),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          const Image(
            image: AssetImage('images/wallpaper.png'),
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: const Text(
                      "Verifique a sua aplicabilidade ao auxílio",
                      style: TextStyle(color: Colors.yellowAccent, fontSize: 25.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: 25.0,
                    child: const Text(
                      "Qual a sua renda familiar?",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.black54, borderRadius: BorderRadius.circular(5),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.black,
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _salaryDropdownValue,
                        icon: const Icon(Icons.arrow_drop_down), iconSize: 40,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        underline: Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        items: salaryList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _salaryDropdownValue = value!;
                            _salaryIndex = salaryList.indexOf(value!);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: 50.0,
                    child: const Text(
                      "Quantos filhos vacinados e matriculados em alguma escola você possui?",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.black54, borderRadius: BorderRadius.circular(5),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.black,
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _childrenDropdownValue,
                        icon: const Icon(Icons.arrow_drop_down), iconSize: 40,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        underline: Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        hint: const Text("Selecione uma opção"),
                        items: childrenList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _childrenDropdownValue = value!;
                            _childrenIndex = childrenList.indexOf(value!);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: 25.0,
                    child: const Text(
                      "Sua família possui pai ausente?",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        height: 50.0,
                        child: ToggleButtons(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          selectedBorderColor: Colors.green[800],
                          borderColor: Colors.white,
                          selectedColor: Colors.white,
                          fillColor: Colors.green[400],
                          color: Colors.white,
                          constraints: const BoxConstraints(
                            minHeight: 40.0,
                            minWidth: 80.0,
                          ),
                          direction: vertical ? Axis.vertical : Axis.horizontal,
                          onPressed: (int index){
                            setState(() {
                              fatherIndex = index;
                              for (int i = 0; i < _selectedFatherChoiceList.length; i++) {
                                _selectedFatherChoiceList[i] = i == fatherIndex;
                              }
                            });
                          },
                          isSelected: _selectedFatherChoiceList,
                          children: choiceList,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: 25.0,
                    child: const Text(
                      "Sua família possui mãe ausente?",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        height: 50.0,
                        child: ToggleButtons(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            selectedBorderColor: Colors.green[800],
                            selectedColor: Colors.white,
                            borderColor: Colors.white,
                            fillColor: Colors.green[400],
                            color: Colors.white,
                            constraints: const BoxConstraints(
                              minHeight: 40.0,
                              minWidth: 80.0,
                            ),
                            direction: vertical ? Axis.vertical : Axis.horizontal,
                            onPressed: (int index){
                              setState(() {
                                motherIndex = index;
                                for (int i = 0; i < _selectedMotherChoiceList.length; i++) {
                                  _selectedMotherChoiceList[i] = i == motherIndex;
                                }
                              });
                            },
                            isSelected: _selectedMotherChoiceList,
                            children: choiceList,
                          ),
                        ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 15,
                        shadowColor: Colors.lightGreen,
                      ),
                      onPressed: (){
                        setState(() {
                          calculateAssistance(_salaryIndex, _childrenIndex, fatherIndex, motherIndex);
                        });
                      },
                      child: const Text(
                        "Verificar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: 50.0,
                    child: Text(
                      "$_message",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}