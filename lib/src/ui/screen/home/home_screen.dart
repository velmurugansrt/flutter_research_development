import 'package:flutter/material.dart';
import 'package:flutter_research_development/src/assets/styles/app_widget_size.dart';
import 'package:flutter_research_development/src/assets/theme/app_colors.dart';
import 'package:flutter_research_development/src/ui/navigation/screen_routes.dart';
import 'package:upi_pay/upi_pay.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Home'),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Best Sellers',
            style: Theme.of(context).textTheme.headline5,
          ),
          _buildBestProductList(),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'Popular',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: _buildPopularProductList(),
          ),
        ],
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _carButtonPressed,
      child: Container(
        alignment: Alignment.topRight,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: null,
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  '4',
                  style: Theme.of(context).accentTextTheme.bodyText1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _carButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bct) {
        return _buildCartSection();
      },
    );
  }

  Widget _buildCartSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Wrap(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Text(
                      'Product 1',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      '@30',
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),
                Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: AppColors.negativeColor,
                      ),
                      onPressed: _updateProductCart,
                    ),
                    Text(
                      '1',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: AppColors.postiveColor,
                      ),
                      onPressed: _updateProductCart,
                    ),
                  ],
                ),
                Text(
                  '@300',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
            Wrap(
              children: <Widget>[
                RaisedButton(
                  elevation: 0,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppWidgetSize.buttonBorderRadius,
                  ),
                  onPressed: _checkoutButtonPressed,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Text(
                        'Place Order - ',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ),
                      Text(
                        '@300',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _checkoutButtonPressed() async {
    debugPrint('txnResponse');

    UpiTransactionResponse txnResponse = await UpiPay.initiateTransaction(
      amount: '10.00',
      app: UpiApplication.googlePay,
      receiverName: 'John',
      receiverUpiAddress: 'johnupi@paytm',
      transactionRef: 'ORD1215236',
      url: 'www.johnshop.com/order/ORD1215236',
      merchantCode: '1032',
      transactionNote: 'Test transaction',
    );
    Navigator.of(context)
        .pushReplacementNamed(ScreenRoutes.ORDER_STATUS_SCREEN);
  }

  void _updateProductCart() {}

  Row _buildBestProductList() {
    return Row(
      children: <Widget>[
        _buildProductItem(),
      ],
    );
  }

  Wrap _buildProductItem({int type = 1}) {
    final double gridSize = 140;
    return Wrap(
      direction: type == 1 ? Axis.vertical : Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          width: gridSize,
          height: gridSize,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  '',
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Most recommented product',
                  style: Theme.of(context).accentTextTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: null,
                ),
              )
            ],
          ),
        ),
        Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              'Product 1',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '₹30.00',
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        )
      ],
    );
  }

  GridView _buildPopularProductList() {
    return GridView.count(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      children: <Widget>[
        _buildProductItem(type: 2),
        _buildProductItem(type: 2),
      ],
    );
  }
}
