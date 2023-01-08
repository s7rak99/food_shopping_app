import 'package:flutter/material.dart';
import 'package:food_shopping_app/layout/user_cubit/cubit.dart';
import 'package:food_shopping_app/model/invoice_model.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PREVIOUS PURCHASES'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ShopCubit.get(context).invoices.isEmpty &&
                ShopCubit.get(context).userModel == null
            ? LinearProgressIndicator()
            : ListView.separated(
                itemBuilder: (context, index) {
                  return buildInvoiceItem(
                      context, ShopCubit.get(context).invoices[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20.0,
                  );
                },
                itemCount: ShopCubit.get(context).invoices.length,
              ),
      ),
    );
  }

  Widget buildInvoiceItem(context, InvoiceModel invoiceModel) {
    return Container(
      height: MediaQuery.of(context).size.width.toInt() <= 450 ? 100.0 : 150,
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(15.0),
            height:  MediaQuery.of(context).size.width.toInt() <= 450
                ? 70.0:100,
            width:  MediaQuery.of(context).size.width.toInt() <= 450
                ? 70.0:100,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(80.0),
            ),
            child: Icon(
              Icons.attach_money,
              size:  MediaQuery.of(context).size.width.toInt() <= 450
                  ? 35.0:50,
              color: Colors.pink[700],
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${invoiceModel.dateTime}'.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize:
                            MediaQuery.of(context).size.width.toInt() <= 450
                                ? 20
                                : 40)),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'total: ${invoiceModel.total}'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width.toInt() <= 450
                          ? 14
                          : 25),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'quantity: ${invoiceModel.quantity}'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width.toInt() <= 450
                          ? 14
                          : 25),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.print,
                color: Colors.pink[700],
                size:  MediaQuery.of(context).size.width.toInt() <= 450
                    ? 35.0:50,
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width.toInt() <= 450
                ?  10.0:35,
          ),
        ],
      ),
    );
  }
}
