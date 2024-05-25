import 'dart:convert';
import 'package:cardapp/product.dart';
import 'package:cardapp/add_product.dart';
import 'package:cardapp/product_model.dart';
import 'package:cardapp/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyCrud extends StatefulWidget {
  const MyCrud({super.key});

  @override
  State<MyCrud> createState() => _MyCrudState();
}

class _MyCrudState extends State<MyCrud> {
  bool _getProductListInPrograss = false;
  List<ProductModel> productList = [];
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Visibility(
          visible: _getProductListInPrograss == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return _buildProduct(productList[index]);
            },
            separatorBuilder: (_, __) => const Divider(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduct(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _getProductList() async {
    _getProductListInPrograss = true;

    setState(() {});
    productList.clear();
    String getProductUrl = 'https://crud.teamrabbil.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(getProductUrl);
    Response response = await get(uri);

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      final jsonproductList = decodeData['data'];
      for (Map<String, dynamic> json in jsonproductList) {
        ProductModel productModel = ProductModel.fromJson(json);
        productList.add(productModel);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Add Product List Failed.Try Again!"),
        ),
      );
    }
    _getProductListInPrograss = false;
    setState(() {});
  }

  Widget _buildProduct(ProductModel product) {
    return ListTile(
      leading: Image.network(
          "https://images.pexels.com/photos/19090/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=600"),
      title: Text(product.productName ?? ''),
      subtitle: Wrap(
        children: [
          SizedBox(width: 5),
          Text('Unit Price: ${product.unitPrice}'),
          SizedBox(width: 5),
          Text("Quantity:${product.quantity}"),
          SizedBox(width: 5),
          Text("Total Price:${product.totalPrice}"),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProduct(
                    product: product,
                  ),
                ),
              );
              if (result == true) {
                _getProductList();
              }
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              _showDeleteConfarmation(product.id!);
            },
            icon: Icon(Icons.delete_forever_outlined),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfarmation(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text("Are You Sure ??"),
          actions: [
            TextButton(
              onPressed: () {
                _deleteProduct(id);
                Navigator.pop(context);
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct(String id) async {
    _getProductListInPrograss = true;

    setState(() {});

    String _deleteProductUrl =
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/$id';
    Uri uri = Uri.parse(_deleteProductUrl);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      _getProductList();
    } else {
      _getProductListInPrograss = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Delete Product Failed.Try Again!"),
        ),
      );
    }
  }
}
