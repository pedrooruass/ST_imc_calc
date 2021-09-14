import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora IMC",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyScreen(),
    );
  }
}

// Tela
class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  // Controlador do campo de texto
  TextEditingController pesoController = TextEditingController();
  final alturaController = TextEditingController();

  // Controlador do formulario
  GlobalKey<FormState> chaveFormulario = GlobalKey<FormState>();

  // variavel que apresentara o informativo de IMC
  String informativo = "Digite seus dados";

  // Valor do IMC
  double imc = 0;

//  TODO Finalizar esse metodo
  // Funcao de calcular IMC
  void calcularImc() {
    // Buscar os Valores

    double peso = double.tryParse(pesoController.text);
    double altura = double.tryParse(alturaController.text);

    if (peso != null && altura != null) {
      // Calcular os Valores

      // Consertanda altura
      altura = altura / 100;

      imc = peso / (altura * altura);

      // Resultado do informativo

      setState(() {
        if (imc < 18.6) {
          informativo = "Abaixo do peso";
        } else if (imc >= 18.6 && imc < 24.9) {
          informativo = "Peso ideal";
        } else if (imc >= 24.9 && imc < 29.9) {
          informativo = "Levemente acima do peso";
        } else if (imc >= 29.9 && imc < 34.9) {
          informativo = "Obesidade 1";
        } else if (imc >= 34.9 && imc <= 39.9) {
          informativo = "Obesidade 2";
        } else if (imc >= 40) {
          informativo = "Obesidade 3";
        }

        informativo += " - IMC: ${imc.toStringAsFixed(1)}";
      });
    } else {
      setState(() {
        informativo = "Digite um valor valido!!";
      });

      alturaController.text = "";
      pesoController.text = "";
    }
  }

// Reinicia Calculadora
  void reiniciarCalculadora() {
// Zerando os campos de textos
    pesoController.text = "";
    alturaController.text = "";

// Reiniciando o informativo
    setState(() {
      informativo = "Digite seus dados";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        centerTitle: true,
        title: Text("Calculadora Imc"),
        actions: [
          IconButton(
            onPressed: () {
              // Reiniciar a calculadora
              reiniciarCalculadora();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: chaveFormulario,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Icon
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.red,
                ),

                // Campo de Texto Peso
                TextFormField(
                  controller: pesoController,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Digite um Valor!";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso(Kg)",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),

                // Espacamento
                SizedBox(height: 20),

                // Campo Texto Altura
                TextFormField(
                  controller: alturaController,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Digite um Valor!";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura(cm)",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),

                // Espacamento
                SizedBox(height: 20),

                // Botao arredondado
                GestureDetector(
                  onTap: () {
                    chaveFormulario.currentState.validate();
                    if (chaveFormulario.currentState.validate()) {
                      // Calcula o IMC
                      calcularImc();

                      // esconder teclado
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Espacamento
                SizedBox(height: 20),

                // Informativo
                Text(
                  informativo,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
