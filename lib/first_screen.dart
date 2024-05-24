import 'package:cardapp/add_product.dart';
import 'package:cardapp/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyCrud extends StatefulWidget {
  const MyCrud({super.key});

  @override
  State<MyCrud> createState() => _MyCrudState();
}

class _MyCruState extends State<MyCrud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildProduct();
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddProduct(),),);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  Widget _buildProduct(){
            leading: Image.network(
                "https://images.pexels.com/photos/19090/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=600"),
            title: Text("Product Name");
            subtitle: Wrap(children: [
              SizedBox(width: 2),

              Text("Unit Price:100"),
              Text("Quantity:100"),
              Text("Total Price:10000"),
            ],
            );
            trailing: Wrap(children: [
              IconButton(
                onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const UpdateProduct(),),);
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
            );
  }
  void _showDeleteConfarmation(){
    showDialog(context: context, builder: (context){
return AlertDialog(
title: Text("Delete"),
content: Text("Are You Sure ??"),
actions: [
  TextButton(onPressed: (){
  Navigator.pop(context);
  }, child: Text("Yes"),),
   TextButton(onPressed: (){
    Navigator.pop(context);
   }, child: Text("No"),),
],
);
    },
    );
  }
}

