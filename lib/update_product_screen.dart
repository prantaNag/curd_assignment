import 'package:cardapp/product.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key, required this.product});
  final Product product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  @override
  void inState() {
    super.initState();
    _nameTEController.text = widget.product.productName;
    _unitPriceTEController.text = widget.product.unitPrice;
    _quantityTEController.text = widget.product.quantity;
    _totalPriceTEController.text = widget.product.totalPrice;
    _imageTEController.text = widget.product.image;
    _productCodeTEController.text = widget.product.productCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Product")),
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
                  ElevatedButton(
                    onPressed: () {
                      if (_fromkey.currentState!.validate()) {}
                    },
                    child: Text("Update"),
                  ),
                ],
              )),
        ),
      ),
    );
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
