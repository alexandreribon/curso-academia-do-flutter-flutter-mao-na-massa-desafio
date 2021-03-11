import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:revenda_gas/app/components/tag_melhor_preco.dart';
import 'package:revenda_gas/app/models/revenda_model.dart';
import 'package:revenda_gas/app/pages/selecionar_produtos_page.dart';

class RevendasPage extends StatefulWidget {
  RevendasPage({Key key}) : super(key: key);

  static String routerName = '/';

  @override
  _RevendasPageState createState() => _RevendasPageState();
}

class _RevendasPageState extends State<RevendasPage> {
  List<RevendaModel> revendas;

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/dados.json').then((jsonData) {
      setState(() {
        List<dynamic> dadosMap = jsonDecode(jsonData);
        revendas = dadosMap.map((map) => RevendaModel.fromMap(map)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Escolha uma Revenda',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.swap_vert, size: 30),
            itemBuilder: (_) {
              return [
                _buildPopupMenuItem('Melhor Avaliação', true),
                _buildPopupMenuItem('Mais Rápido', true),
                _buildPopupMenuItem('Mais Barato', true),
              ];
            },
          ),
          PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.only(top: 11, right: 10),
              child: Text(
                '?',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
            itemBuilder: (_) {
              return [
                _buildPopupMenuItem('Suporte', false, Colors.blue),
                _buildPopupMenuItem('Termos de serviço', false, Colors.blue),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Botijões de 13Kg em:',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      Text(
                        'Av. Paulista, 1001',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Paulista, São Paulo, SP',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 30,
                    ),
                    Text('Mudar', style: TextStyle(color: Colors.blue, fontSize: 15)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: revendas?.length ?? 0,
              itemBuilder: (_, index) {
                return _buildCardRevenda(index);
              },
            ),
          )
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String nome, bool objCheckBox, [Color corMenu = Colors.black]) {
    return PopupMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nome,
            style: TextStyle(color: corMenu),
          ),
          Visibility(
            child: Checkbox(onChanged: (bool value) => print(value), value: false),
            visible: objCheckBox,
          ),
        ],
      ),
    );
  }

  Widget _buildCardRevenda(int index) {
    var revenda = revendas[index];

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        SelecionarProdutosPage.routerName,
        arguments: revenda,
      ),
      child: Card(
        margin: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 120,
              decoration: BoxDecoration(
                color: Color(int.parse('FF${revenda.cor}', radix: 16)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Center(
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    revenda.tipo,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 120,
                padding: EdgeInsets.only(left: 10, top: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(revenda.nome)),
                        Visibility(
                          child: TagMelhorPreco(),
                          visible: revenda.melhorPreco,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nota',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  revenda.nota.toString(),
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.star, color: Colors.yellow),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tempo Médio',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            SizedBox(height: 11),
                            Row(
                              children: [
                                Text(
                                  revenda.tempoMedio,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    'min',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Preço',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'R\$ ${revenda.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
