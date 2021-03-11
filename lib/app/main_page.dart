import 'package:flutter/material.dart';
import 'package:revenda_gas/app/models/revenda_model.dart';
import 'package:revenda_gas/app/pages/revendas_page.dart';
import 'package:revenda_gas/app/pages/selecionar_produtos_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revenda de Gás',
      home: RevendasPage(),
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          case '/selecionar_produtos':
            var revenda = settings.arguments as RevendaModel;
            page = SelecionarProdutosPage(revenda: revenda);
            break;
        }

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => page,
        );
      },
    );
  }
}
