import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryapp/Data/models/product_model.dart';
import 'package:groceryapp/Other/Customgrid.dart';
import 'package:groceryapp/Pages/Search/Search_bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBloc searchBloc = SearchBloc();
  final TextEditingController searchController = TextEditingController();
  List<product_model> productList = [];
  List<product_model> filteredList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(filterProducts);
    searchBloc.add(SearchInitialEvent());
  }

  @override
  void dispose() {
    searchController.dispose();
    searchBloc.close();
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
      body: BlocConsumer<SearchBloc, SearchState>(
        bloc: searchBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is SearchActionState,
        buildWhen: (previous, current) => current is! SearchActionState,
        builder: (context, state) {
          if (state is SearchInitial || state is SearchLoadingState) {
            return LoadingData(
                state is SearchLoadingState ? state.message : "Starting up...");
          } else if (state is SearchSuccessState) {
            if (productList != state.ProductList) {
              productList = state.ProductList;
              if (searchController.text.isEmpty) {
                filteredList = List.from(productList);
              } else {
                filterProducts();
              }
            } // Initialize filteredList
            return ProductGrid(filteredList, searchController);
          } else if (state is SearchLoadErrorState) {
            return Center(
              child: Text("Error: ${state.error}"),
            );
          } else {
            return Center(child: Text("Unexpected state: $state"));
          }
        },
      ),
    );
  }
}

Widget ProductGrid(
    List<product_model> filteredList, TextEditingController controller) {
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

Widget LoadingData(String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CircularProgressIndicator(), Text(message)],
    ),
  );
}
