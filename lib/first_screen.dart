import 'dart:convert';
import 'package:cardapp/product.dart';
import 'package:cardapp/add_product.dart';
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
  List<Product> productList = [];
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
      body: Visibility(
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
      for (Map<String, dynamic> p in jsonproductList) {
        Product product = Product(
          id: p['_id'] ?? ' ',
          image: p['Img'] ?? ' ',
          productCode: p['ProductCode'] ?? ' ',
          productName: p['ProductName'] ?? ' ',
          quantity: p['Qty'] ?? '',
          totalPrice: p['TotalPrice'] ?? ' ',
          unitPrice: p['UnitPrice'] ?? ' ',
        );
        productList.add(product);
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

  Widget _buildProduct(Product product) {
    return ListTile(
      leading: Image.network(
          "https://images.pexels.com/photos/19090/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=600"),
      title: Text(product.productName),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProduct(),
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              _showDeleteConfarmation();
            },
            icon: Icon(Icons.delete_forever_outlined),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfarmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text("Are You Sure ??"),
          actions: [
            TextButton(
              onPressed: () {
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
}
