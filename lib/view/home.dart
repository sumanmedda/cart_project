import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/bloc/home_bloc.dart';
import './cart.dart';
import '../controller/widgets/product_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context
        .read<HomeBloc>()
        .add(HomeInitialEvent()); //adding data to the stream
    super.initState();
  }

  // final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: const Text(
                  'Products',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Cart()));
                      },
                      icon:
                          const Icon(Icons.shopping_cart, color: Colors.black)),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        // homeBloc: homeBloc,
                        productDataModel: successState.products[index]);
                  }),
            );

          case HomeErrorState:
            return const Scaffold(body: Center(child: Text('Error')));
          default:
            return const SizedBox();
        }
      },
    );
  }
}
