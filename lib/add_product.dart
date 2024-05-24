import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  bool _addNewProductInPrograss = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Product")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _fromkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: "Name",
                      labelText: "Name",
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Write your product name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _unitPriceTEController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Unit Price",
                      labelText: "Unit Price",
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Input unit price";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _productCodeTEController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Product Code",
                      labelText: "Product Code",
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Input Product Code";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _quantityTEController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Quantity",
                      labelText: "Quantity",
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Input quantiity";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _totalPriceTEController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Total Price",
                      labelText: "Total Price",
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Input total price";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _imageTEController,
                    decoration: InputDecoration(
                      hintText: "Image",
                      labelText: "Image",
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Input Image";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: _addNewProductInPrograss == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_fromkey.currentState!.validate()) {
                          _addProduct();
                        }
                      },
                      child: Text("Add"),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> _addProduct() async {
    _addNewProductInPrograss = true;
    setState(() {});
    const String addProductUrl =
        'https://crud.teamrabbil.com/api/v1/CreateProduct';

    Uri uri = Uri.parse(addProductUrl);

    Map<String, dynamic> inputData = {
      "ProductName": _nameTEController.text,
      "ProductCode": _productCodeTEController.text,
      "Img": _imageTEController.text.trim(),
      "UnitPrice": _unitPriceTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
    };

    Response response = await post(
      uri,
      body: jsonEncode(inputData),
      headers: {'contant-type': 'application/Json'},
    );
    print(response.statusCode);
    print(response.body);
    print(response.headers);

    _addNewProductInPrograss = false;
    setState(() {});

    if (response.statusCode == 200) {
      _imageTEController.clear();
      _nameTEController.clear();
      _productCodeTEController.clear();
      _quantityTEController.clear();
      _totalPriceTEController.clear();
      _unitPriceTEController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Add New Product Successfully"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Add New Product Failed.Try Again!"),
        ),
      );
    }
  }

  @override
  void dispose() {
    _imageTEController.dispose();
    _nameTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _unitPriceTEController.dispose();

    super.dispose();
  }
}
