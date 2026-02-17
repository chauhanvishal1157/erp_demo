import 'package:erp_demo/common/common_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class ViewOrderScreen extends StatefulWidget {
  final String orderNo;
  final String customerName;
  final String phoneNum;
  final String email;
  final String branch;

  const ViewOrderScreen({
    required this.orderNo,
    required this.customerName,
    required this.phoneNum,
    required this.email,
    required this.branch,
    super.key});

  @override
  State<ViewOrderScreen> createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
          title: "View Order",
        showAdd: true,
        addIconColor: AppColors.primary,
        addIcon: Icons.edit_outlined,
        showIdBadge: true,
        idText: "ID:#${widget.orderNo}",
      ),
      body: SafeArea(
        child: ListView(
          padding:  EdgeInsets.all(15),
          children:  [
            ExpandableCard(
              title: "Client Details",
              icon: Icons.person_outline,
              child: ClientDetailsScreen(
                customerName: widget.customerName,
                phoneNum: widget.phoneNum,
                email: widget.email,
                branch: widget.branch,
              ),
            ),
            SizedBox(height: 15,),
            ExpandableCard(
              title: "Billing Address",
              icon: Icons.receipt_long,
              child: AddressContent(
                address: "Bhopal, Ahmedabad",
                pin: "380045",
              ),
            ),
            SizedBox(height: 15),
            ExpandableCard(
              title: "Shipping Address",
              icon: Icons.local_shipping,
              child: AddressContent(
                address: "Science city",
                pin: "142587",
              ),
            ),
            SizedBox(height: 15),
            ExpandableCard(
              title: "Product Summary",
              icon: Icons.bar_chart,
              child: ProductSummaryContent(),
            ),
            SizedBox(height: 15),
            ExpandableCard(
              title: "Billing Details",
              icon: Icons.bar_chart,
              child: BillingDetailsContent(),
            ),
          ],
        ),
      ),
    );
  }
}


/// COMMON EXPANDABLE CARD

class ExpandableCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const ExpandableCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(
            color: Colors.blue.withValues(alpha: 0.1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                setState(() => expanded = !expanded);
              },
              child: Row(
                children: [
                  _icon(
                      widget.icon,
                      Colors.blue
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: _iconArrow(
                        Icons.keyboard_arrow_down,
                        Colors.blue
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            ),
            child:   AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: expanded
                  ? Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: widget.child,
              )
                  : const SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}

/// ADDRESS CONTENT

class AddressContent extends StatelessWidget {
  final String address;
  final String pin;

  const AddressContent({
    super.key,
    required this.address,
    required this.pin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tile(Icons.home, "Address", address),
        _tile(Icons.public, "Country", "India"),
        _tile(Icons.map, "State", "Gujarat"),
        _tile(Icons.location_city, "City", "Ahmedabad"),
        _tile(Icons.pin_drop, "Pin Code", pin),
      ],
    );
  }

  Widget _tile(
      IconData icon,
      String title,
      String value,
      ) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
              icon,
              size: 20,
              color: Colors.grey,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  title,
                  style: const TextStyle(
                      color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color:  AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// PRODUCT SUMMARY

class ProductSummaryContent extends StatefulWidget {
  const ProductSummaryContent({super.key});

  @override
  State<ProductSummaryContent> createState() => _ProductSummaryContentState();
}

class _ProductSummaryContentState extends State<ProductSummaryContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border.all(
            color: Colors.green.withValues(alpha: 0.1),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                _icon(
                    Icons.inventory_2_outlined,
                    Colors.green
                ),
                const SizedBox(width: 12),
                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Product 2",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green
                          )
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                            "1122233",
                            style: TextStyle(
                              fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.black45
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                _iconArrow(
                    Icons.keyboard_arrow_up,
                    Colors.green,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration:BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                _row("QTY × Price", "5 × ₹20.00"),
                SizedBox(height: 10,),
                _row("Subtotal", "₹95.12"),
                const SizedBox(height: 15),
                _tax("GST", "4.88",),
                const SizedBox(height: 15),
                _total(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String t, String v) {
    return Row(
      children: [
        Expanded(
            child: Text(
                t,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                )
            ),
        ),
        Text(
            v,
            style: const TextStyle(
              fontSize: 12,
                fontWeight: FontWeight.w600,
            )
        ),
      ],
    );
  }

  Widget _tax(String title, String value,) {
    return Container(
      padding:  EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.05),
        border: Border.all(
            color: Colors.blue.shade50,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.receipt,
            color: AppColors.primary,
            size: 18,
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Text(
                title,
                style:  TextStyle(
                  fontSize: 13,
                    fontWeight: FontWeight.w600,
                ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 3
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  size: 14,
                ),
                Icon(
                  Icons.currency_rupee,
                  size: 12,
                ),
                Text(
                  value,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                    ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.primary,
                  size: 12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _total() {
    return Container(
      padding:  EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.05),
        border: Border.all(
          color: Colors.blue.shade50,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children:  [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade300,
                  blurRadius: 4,
                  offset: Offset(2, 2)
                )
              ]
            ),
            child: Icon(
                Icons.wallet,
                size: 20,
                color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Amount",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    fontSize: 13
                  ),
                ),
                Text(
                  "All taxes included",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontSize: 11
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 2
            ),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue.shade300,
                      blurRadius: 4,
                      offset: Offset(2, 2)
                  )
                ]
            ),
            child: Row(
              children: [
                Icon(
                  Icons.currency_rupee,
                  size: 16,
                  color: Colors.white,
                ),
                Text(
                  "100.00",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// BILLING DETAILS

class BillingDetailsContent extends StatelessWidget {
  const BillingDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row("Total MRP", "₹5000.00", Colors.green,Icons.local_offer_outlined),
        _row("Total Discount", "- ₹ 0.00", Colors.red,Icons.discount_outlined),
        _row("Total Taxable Value", "₹ 5000.00", Colors.green,Icons.attach_money_outlined),
        _row("CGST", "+ ₹ 2.44", Colors.orange,Icons.account_balance_outlined),
        _row("SGST", "+ ₹ 2.44", Colors.orange,Icons.account_balance_outlined),
        const SizedBox(height: 12),
        _final(),
      ],
    );
  }

  Widget _row(String title, String value, Color color,IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
                size: 18,
              ),
              SizedBox(width: 5,),
              Expanded(
                  child: Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                      ),
                  ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  border: Border.all(color:color.withValues(alpha: 0.3),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
            height: 1,
          )
        ],
      ),
    );
  }

  Widget _final() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.15),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children:  [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
                Icons.payments_outlined,
                size: 20,
                color: Colors.white
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
                "Order Total",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 4
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.currency_rupee,
                  size: 16,
                  color: Colors.white,
                ),
                Text(
                    "5000.00",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Icon

Widget _iconArrow(IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Icon(
      icon,
      size: 20,
      color:  color,
    ),
  );
}

Widget _icon(IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Icon(
      icon,
      size: 20,
      color: color,
    ),
  );
}



class ClientDetailsScreen extends StatelessWidget {
  final String customerName;
  final String phoneNum;
  final String email;
  final String branch;

  const ClientDetailsScreen({
    super.key,
    required this.customerName,
    required this.phoneNum,
    required this.email,
    required this.branch,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _detailRow(
            Icons.person,
            "Name",
            customerName,
            valueColor: AppColors.primary
        ),
        _detailRow(
          Icons.business,
          "Company",
          "",
          valueColor: AppColors.primary,
        ),
        _detailRow(
            Icons.phone,
            "Phone Number",
            phoneNum,
            valueColor: AppColors.primary,
            textColor: AppColors.primary
        ),
        _detailRow(
            Icons.message,
            "WhatsApp Number",
             phoneNum,
            valueColor: Colors.green,
            textColor: Colors.green,
        ),
        _detailRow(
          Icons.email,
          "Email",
          email,
          valueColor: AppColors.primary,
        ),
        _detailRow(
          Icons.location_on,
          "Branch",
          branch,
          valueColor: AppColors.primary,
        ),
      ],
    );
  }

  Widget _detailRow(
      IconData icon,
      String title,
      String value, {
        Color valueColor = Colors.black,
        Color textColor = Colors.black,

      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: valueColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
                icon,
                color: valueColor,
                size: 16,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}





