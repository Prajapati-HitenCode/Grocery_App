import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryapp/Data/product_model.dart';
import 'package:groceryapp/Other/Customgrid.dart';
import 'package:groceryapp/Pages/Home/Home_bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();
  final TextEditingController searchController = TextEditingController();
  List<product_model> productList = [];
  List<product_model> filteredList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(filterProducts);
    homeBloc.add(HomeInitialEvent());
  }

  @override
  void dispose() {
    searchController.dispose();
    homeBloc.close();
    super.dispose();
  }

  void filterProducts() {
    final query = searchController.text.toLowerCase().trim();

    setState(() {
      if (query.isEmpty) {
        filteredList = List.from(productList);
      } else {
        filteredList = productList.where((product) {
          return product.name.toLowerCase().contains(query);
        }).toList();
      }
      debugPrint("Filtered list length: \${filteredList.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listener: (context, state) {},
        listenWhen: (previous,current)=> current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        builder: (context, state) {
          if (state is HomeInitial || state is HomeLoading_state) {
            return LoadingData(state is HomeLoading_state ? state.message : "Starting up...");
          } else if (state is HomeLoadSuccess_state) {
            if (productList != state.productList) {
              productList = state.productList;
              if (searchController.text.isEmpty) {
                filteredList = List.from(productList);
              } else {
                filterProducts();
              }
            } // Initialize filteredList
            return ProductGrid(filteredList, searchController);
          } else if (state is HomeLoadError_state) {
            return ErrorState(state.error);
          } else {
            return Center(child: Text("Unexpected state: $state"));
          }
        },
      ),
    );
  }

  Widget LoadingData(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator(), Text(message)],
      ),
    );
  }

  Widget ErrorState(String error) {
    return Center(
      child: Text("Error: $error"),
    );
  }

  Widget ProductGrid(List<product_model> filteredList, TextEditingController controller) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: CustomGrid(productList: filteredList),
          ),
        ],
      ),
    );
  }
}