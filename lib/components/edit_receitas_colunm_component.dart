import 'package:flutter/material.dart';

import '../database/receitas_database.dart';
import '../models/receitas_model.dart';
import '../view/lista_receitas_page.dart';
import '../widgets/textfield_widget.dart';

class EditReceitasColunmComponent extends StatefulWidget {
  const EditReceitasColunmComponent({
    Key? key,
    required this.nomeReceita,
    this.argsIDFromHomePage,
    required this.ingredientes,
    required this.modoPreparo,
    required this.tipoReceita,
  }) : super(key: key);

  final TextEditingController nomeReceita;
  final ReceitasModel? argsIDFromHomePage;
  final TextEditingController ingredientes;
  final TextEditingController modoPreparo;
  final String tipoReceita;

  @override
  State<EditReceitasColunmComponent> createState() =>
      _EditReceitasColunmComponentState();
}

class _EditReceitasColunmComponentState
    extends State<EditReceitasColunmComponent> {
  List<String> listTipoReceita = ['Entrada', 'Prato Principal', 'Sobremesa'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldCustomWidget(
          controller: widget.nomeReceita,
          textInputAction: TextInputAction.next,
          hintText: widget.argsIDFromHomePage!.nomeReceita,
        ),
        TextFieldCustomWidget(
          controller: widget.ingredientes,
          textInputAction: TextInputAction.next,
          hintText: widget.argsIDFromHomePage!.ingredientes,
        ),
        TextFieldCustomWidget(
          controller: widget.modoPreparo,
          textInputAction: TextInputAction.next,
          hintText: widget.argsIDFromHomePage!.modoPreparo,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Tipo da Receita'),
            DropdownButton<String>(
              hint: const Text('Tipo da Receita'),
              items:
                  listTipoReceita.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  widget.argsIDFromHomePage!.tipoReceita = newValue!;
                });
              },
              value: widget.argsIDFromHomePage!.tipoReceita,
            ),
          ],
        ),
        const SizedBox(
          height: 300,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () async {
                setState(
                  () {
                    RecipeDatabase.instance.update(
                      ReceitasModel(
                        id: widget.argsIDFromHomePage!.id,
                        nomeReceita: widget.argsIDFromHomePage!.nomeReceita,
                        ingredientes: widget.argsIDFromHomePage!.ingredientes,
                        modoPreparo: widget.argsIDFromHomePage!.modoPreparo,
                        tipoReceita: widget.argsIDFromHomePage!.tipoReceita,
                      ),
                    );
                  },
                );
                Navigator.of(context).pop();
              },
              child: const Text('Salvar altera????o'),
            ),
            const Icon(Icons.check),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return ListaReceitas(
                tipoReceita: widget.argsIDFromHomePage!.tipoReceita,
              );
            }));
              },
              child: const Text('Cancelar'),
            ),
            const Icon(Icons.close),
          ],
        ),
      ],
    );
  }
}
