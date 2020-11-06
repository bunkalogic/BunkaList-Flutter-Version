import 'package:bunkalist/src/core/utils/get_list_company.dart';
import 'package:flutter/material.dart';


class ScrollCompanyWidget extends StatefulWidget {
  final List<Company> companies; 
  
  ScrollCompanyWidget({this.companies});

  @override
  _ScrollCompanyWidgetState createState() => _ScrollCompanyWidgetState();
}

class _ScrollCompanyWidgetState extends State<ScrollCompanyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.companies.length,
        itemBuilder: (context, i) => _buildItemCompany(widget.companies[i])
      ),
    );
  }

  Widget _buildItemCompany(Company company) {
    return Column(
      children: [
        _itemImageCompany(company),
        _itemNameCompany(company)
      ],
    );  
  }

  Widget _itemImageCompany(Company company) {
    return GestureDetector(
      onTap: (){

         Navigator.pushNamed(context, '/ExplorerCompany', arguments: company);

      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.network(
            company.imagePath,
            height: 50.0,
            width: 50.0,
            fit: BoxFit.contain,
          ),
        )
      ),
    );
  }

  Widget _itemNameCompany(Company company) {
    return Center(
      child: Text(
        company.label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }
}