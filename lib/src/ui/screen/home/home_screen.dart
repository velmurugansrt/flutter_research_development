import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_research_development/src/assets/styles/app_widget_size.dart';
import 'package:flutter_research_development/src/assets/theme/app_colors.dart';
import 'package:flutter_research_development/src/blocs/home/home_bloc.dart';
import 'package:flutter_research_development/src/data/store/app_store.dart';
import 'package:flutter_research_development/src/models/home/product_list_response_model.dart';
import 'package:flutter_research_development/src/ui/navigation/screen_routes.dart';
import 'package:upi_pay/upi_pay.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _homeBloc;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeBloc = BlocProvider.of<HomeBloc>(context);
      _homeBloc.add(FetchUserLoginEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar() {
    String username = AppStore().getUserDetails().username;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(username),
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

  BlocBuilder<HomeBloc, HomeState> _buildBestProductList() {
    return BlocBuilder<HomeBloc, HomeState>(
      condition: (HomeState prevState, HomeState currentState) {
        return currentState is ProductListState;
      },
      builder: (BuildContext context, HomeState state) {
        if (state is ProductListState) {
          final List<ProductList> productList = state.productList;
          return SingleChildScrollView(
            child: Row(
              children: List.generate(productList.length,
                  (index) => _buildProductItem(productList[index])),
            ),
            scrollDirection: Axis.horizontal,
          );
        }
        return Container();
      },
    );
  }

  Padding _buildProductItem(ProductList productItem, {int type = 1}) {
    const double gridSize = 140;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Wrap(
        direction: type == 1 ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 16),
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
                    productItem.image,
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
                    productItem.decription,
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
          SizedBox(
              width: gridSize,
              child: Wrap(
                direction: Axis.vertical,
                children: <Widget>[
                  Text(
                    productItem.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    '₹ ${productItem.price}',
                    style: Theme.of(context).textTheme.headline3,
                  )
                ],
              ))
        ],
      ),
    );
  }

  BlocBuilder<HomeBloc, HomeState> _buildPopularProductList() {
    return BlocBuilder<HomeBloc, HomeState>(
      condition: (HomeState prevState, HomeState currentState) {
        return currentState is ProductListState;
      },
      builder: (BuildContext context, HomeState state) {
        if (state is ProductListState) {
          final List<ProductList> productList = state.productList;
          return GridView.count(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            children: List.generate(productList.length,
                (index) => _buildProductItem(productList[index], type: 2)),
          );
        }
        return Container();
      },
    );
  }
}
