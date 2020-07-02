import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_research_development/src/assets/styles/app_widget_size.dart';
import 'package:flutter_research_development/src/assets/theme/app_colors.dart';
import 'package:flutter_research_development/src/blocs/home/home_bloc.dart';
import 'package:flutter_research_development/src/constants/app_constants.dart';
import 'package:flutter_research_development/src/data/store/app_store.dart';
import 'package:flutter_research_development/src/models/home/cart_list_model.dart';
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
    final String username = AppStore().getUserDetails().username;
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

  BlocBuilder<HomeBloc, HomeState> _buildFloatingActionButton() {
    return BlocBuilder<HomeBloc, HomeState>(
      condition: (HomeState prevState, HomeState currentState) {
        return currentState is CartDetailsState;
      },
      builder: (BuildContext context, HomeState state) {
        if (state is CartDetailsState && state.cartList.isNotEmpty) {
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
                        state.cartList.length.toString(),
                        style: Theme.of(context).accentTextTheme.bodyText1,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  void _carButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bct) {
        return BlocProvider.value(
          value: _homeBloc,
          child: Container(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
            child: _buildCartSection(),
          ),
        );
      },
    );
  }

  BlocBuilder<HomeBloc, HomeState> _buildCartSection() {
    return BlocBuilder<HomeBloc, HomeState>(
      condition: (HomeState prevState, HomeState currentState) {
        return currentState is CartDetailsState;
      },
      builder: (BuildContext context, HomeState state) {
        if (state is CartDetailsState && state.cartList.isNotEmpty) {
          List<Widget> coloumnItem = List.generate(
            state.cartList.length,
            (index) {
              CartList cartItem = state.cartList[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Text(
                          cartItem.name,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          '₹ ${cartItem.price}',
                          style: Theme.of(context).textTheme.headline3,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.remove,
                            color: AppColors.negativeColor,
                          ),
                          onPressed: () => _productActionPressed(
                              AppConstants.MINUS, cartItem),
                        ),
                        Text(
                          '${cartItem.count}',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: AppColors.postiveColor,
                          ),
                          onPressed: () => _productActionPressed(
                              AppConstants.PLUS, cartItem),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '₹ ${cartItem.totalPrice}',
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              );
            },
          );
          coloumnItem.add(
            Wrap(
              children: <Widget>[
                RaisedButton(
                  elevation: 0,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppWidgetSize.buttonBorderRadius,
                  ),
                  onPressed: () => _checkoutButtonPressed(state.total),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Text(
                        'Place Order - ',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ),
                      Text(
                        '₹ ${state.total}',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: coloumnItem,
            ),
          );
        }
        return Text(
          'No data available',
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
        );
      },
    );
  }

  Future<void> _checkoutButtonPressed(String total) async {
    final String username = AppStore().getUserDetails().username;

    UpiTransactionResponse txnResponse = await UpiPay.initiateTransaction(
      amount: '1',
      app: UpiApplication.phonePe,
      receiverName: 'Velmurugan',
      receiverUpiAddress: 'rvelmurugan1996-1@okaxis',
      transactionRef: 'ORD1215236',
      merchantCode: '1032',
    );
    Navigator.of(context)
        .pushReplacementNamed(ScreenRoutes.ORDER_STATUS_SCREEN);
  }

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
                    onPressed: () =>
                        _productActionPressed(AppConstants.PLUS, productItem),
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

  void _productActionPressed(String actionType, dynamic productItem) {
    _homeBloc.add(ProductActionEvent(actionType, productItem));
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
