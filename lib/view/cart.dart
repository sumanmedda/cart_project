import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/bloc/home_bloc.dart';
import '../models/homeproduct.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var amount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_backspace_outlined),
          color: Colors.black,
        ),
        title: const Text(
          'Cart Items',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        // bloc: cartBloc,
        builder: (context, state) {
          final successState = state as HomeLoadedSuccessState;
          List<ProductDataModel> cartsList = successState.carts;

          for (int i = 0; i < cartsList.length; i++) {
            amount = amount + cartsList[i].price;
          }

          switch (state.runtimeType) {
            case HomeLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeLoadedSuccessState:
              return amount == 0
                  ? const Center(
                      child: Text('No Products Found'),
                    )
                  : Column(
                      children: [
                        Expanded(
                          flex: 20,
                          child: ListView.builder(
                              itemCount: successState.carts.length,
                              itemBuilder: (context, index) {
                                var path = cartsList[index];
                                return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.network(path.imageUrl),
                                    ),
                                    title: Text(path.name),
                                    subtitle: Text('₹${path.price.toString()}'),
                                    trailing: SizedBox(
                                      width: 120,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  path.isCartSelected == true
                                                      ? Colors.red
                                                      : Colors.green),
                                          onPressed: () {
                                            if (path.isCartSelected == false) {
                                              context.read<HomeBloc>().add(
                                                      HomeProductCartButtonClickedEvent(
                                                    clickedProduct: path,
                                                  ));
                                            } else {
                                              calAmount(cartsList);
                                              context
                                                  .read<HomeBloc>()
                                                  .add(OnCartRemove(
                                                    removeCart: path,
                                                  ));
                                            }
                                          },
                                          child: path.isCartSelected == true
                                              ? const Text('Remove')
                                              : const Text('Add To Cart')),
                                    ));
                              }),
                        ),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Amount : ',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    '₹${amount.toString()}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    );

            case HomeErrorState:
              return const Center(child: Text('Error'));
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  calAmount(List<ProductDataModel> cartsList) {
    for (int i = 0; i < cartsList.length; i++) {
      amount = amount - cartsList[i].price;
    }
  }
}
