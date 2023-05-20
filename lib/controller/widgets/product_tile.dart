import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/homeproduct.dart';
import '../bloc/home_bloc.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  const ProductTileWidget({
    super.key,
    required this.productDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        // bloc: homeBloc,
        builder: (context, state) {
      return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.network(productDataModel.imageUrl),
          ),
          title: Text(productDataModel.name),
          subtitle: Text('₹${productDataModel.price.toString()}'),
          trailing: SizedBox(
            width: 120,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: productDataModel.isCartSelected == true
                        ? Colors.red
                        : Colors.green),
                onPressed: () {
                  if (productDataModel.isCartSelected == false) {
                    context
                        .read<HomeBloc>()
                        .add(HomeProductCartButtonClickedEvent(
                          clickedProduct: productDataModel,
                        ));
                  } else {
                    context.read<HomeBloc>().add(OnCartRemove(
                          removeCart: productDataModel,
                        ));
                  }
                },
                child: productDataModel.isCartSelected == true
                    ? const Text('Remove')
                    : const Text('Add To Cart')),
          ));
    });
  }
}
