import 'package:flutter/material.dart';
import 'package:sell_or_swap/bloc/store_items_bloc.dart';
import 'package:sell_or_swap/components/store_item_card.dart';
import 'package:sell_or_swap/models/item.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/networking/api_response.dart';
import 'package:sell_or_swap/size_config.dart';

class SellerShopGridItems extends StatefulWidget {
  const SellerShopGridItems({
    Key key,
    @required this.store,
  }) : super(key: key);

  final Store store;

  @override
  _SellerShopGridItemsState createState() => _SellerShopGridItemsState();
}

class _SellerShopGridItemsState extends State<SellerShopGridItems> {
  // Stream Bloc for fetching data from API
  StoreItemsBloc _storeItemsBloc;
  @override
  void initState() {
    super.initState();
    _storeItemsBloc = StoreItemsBloc(widget.store.id ?? "");
  }

  @override
  void dispose() {
    _storeItemsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Response<List<Item>>>(
      stream: _storeItemsBloc.storeItemStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
              break;
            case Status.EMPTY:
              return Center(child: Text("Empty"));
              break;
            case Status.COMPLETED:
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: getUiWidth(5),
                  mainAxisSpacing: getUiWidth(5),
                ),
                itemCount: snapshot.data.data.length,
                itemBuilder: (context, index) {
                  return StoreItemCard(
                    item: snapshot.data.data[index],
                  );
                },
              );
              break;
            case Status.ERROR:
              return Center(
                child: Text("Error " + snapshot.data.message),
              );
              break;
            default:
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
        return Center(
          child: Text("Starting.."),
        );
      },
    );
  }
}
