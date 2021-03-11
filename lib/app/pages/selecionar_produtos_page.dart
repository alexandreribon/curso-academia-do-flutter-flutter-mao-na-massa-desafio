import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:revenda_gas/app/components/status_ball.dart';
import 'package:revenda_gas/app/models/revenda_model.dart';

class SelecionarProdutosPage extends StatefulWidget {
  static String routerName = '/selecionar_produtos';

  final RevendaModel revenda;

  const SelecionarProdutosPage({
    Key key,
    @required this.revenda,
  }) : super(key: key);

  @override
  _SelecionarProdutosPageState createState() => _SelecionarProdutosPageState(revenda: revenda);
}

class _SelecionarProdutosPageState extends State<SelecionarProdutosPage> {
  final RevendaModel revenda;
  int quantidade = 1;
  double valorTotal;

  _SelecionarProdutosPageState({@required this.revenda}) {
    valorTotal = revenda.preco;
  }

  var appBar = AppBar(
    title: Text(
      'Selecionar Produtos',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 11, right: 10),
        child: Text(
          '?',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
    ],
  );

  void adicionar() {
    setState(() {
      quantidade++;
      valorTotal = revenda.preco * quantidade;
    });
  }

  void remover() {
    if (quantidade > 0) {
      setState(() {
        quantidade--;
        valorTotal = revenda.preco * quantidade;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //var mediaQuery = MediaQuery.of(context);
    var telaWidth = ScreenUtil.screenWidthDp; //mediaQuery.size.width;
    var telaHeight = ScreenUtil.screenHeightDp; //mediaQuery.size.height;
    var statusBarHeight = ScreenUtil.statusBarHeight; //mediaQuery.padding.top;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appBar,
      body: Container(
        width: telaWidth,
        height: telaHeight - appBar.preferredSize.height - statusBarHeight,
        child: Column(
          children: [
            _buildStatusProgressOrder(),
            _buildSeparator(),
            _buildSubTitleRevenda(),
            _buildContentBuy(),
            Expanded(child: SizedBox()),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusProgressOrder() {
    return Container(
      padding: EdgeInsets.all(25),
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const StatusBall(status: 'Comprar', active: true),
          _buildStatusDivider(),
          const StatusBall(status: 'Pagamento', active: false),
          _buildStatusDivider(),
          const StatusBall(status: 'Confirmação', active: false),
        ],
      ),
    );
  }

  Widget _buildSubTitleRevenda() {
    return Container(
      //margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 33,
            height: 33,
            decoration: BoxDecoration(
              color: Color(int.parse('FF${revenda.cor}', radix: 16)),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                quantidade.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '${revenda.nome} - Botijão de 13Kg',
                style: TextStyle(fontSize: 38),
                maxLines: 2,
                textScaleFactor: ScreenUtil().scaleText,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'R\$',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Text(
                valorTotal.toStringAsFixed(2).replaceAll('.', ','),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentBuy() {
    return Container(
      margin: EdgeInsets.all(18),
      width: ScreenUtil.screenWidthDp * 0.9, //MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.home,
                  size: 40,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        revenda.nome,
                        style: TextStyle(fontSize: 14),
                        maxLines: 2,
                      ),
                      SizedBox(height: 11),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Text(revenda.nota.toString()),
                          ),
                          Icon(Icons.star, size: 10, color: Colors.orange),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text('${revenda.tempoMedio} min'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        color: Color(int.parse('FF${revenda.cor}', radix: 16)),
                        child: Text(
                          revenda.tipo,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        revenda.horarioFunc,
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Botijão de 13Kg',
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 5),
                      Text(
                        revenda.nome,
                        style: TextStyle(fontSize: 38),
                        maxLines: 2,
                        textScaleFactor: ScreenUtil().scaleText,
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              'R\$',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          Text(
                            revenda.preco.toStringAsFixed(2).replaceAll('.', ','),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                padding: EdgeInsets.only(right: 8),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                        onTap: () => remover(),
                        child: Icon(Icons.remove),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/prod_icon-gas.png'),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 12),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            quantidade.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                        onTap: () => adicionar(),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: RaisedButton(
        onPressed: () {},
        textColor: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          width: 250,
          height: 70,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[200], Colors.blue[600]],
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              'IR PARA O PAGAMENTO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusDivider() {
    return Expanded(
      child: Column(
        children: [
          Divider(color: Colors.grey),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      width: double.infinity,
      height: 2,
      color: Colors.grey[300],
    );
  }
}
