import 'package:bunkalist/src/core/utils/get_list_company.dart';
import 'package:flutter/material.dart';


class ListCompaniesAndNetworkWidget extends StatefulWidget {
  
  final List<Company> companies; 
  ListCompaniesAndNetworkWidget({@required this.companies});

  @override
  _ListCompaniesAndNetworkWidgetState createState() => _ListCompaniesAndNetworkWidgetState();
}

class _ListCompaniesAndNetworkWidgetState extends State<ListCompaniesAndNetworkWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
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
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: _getImage(company),
        )
      ),
    );
  }

  Widget _getImage(Company company){
    
    if(company.imagePath == ''){

      return Icon(
        Icons.broken_image_rounded,
        color: Colors.grey,
        size: 40,
      );

    }else{

      return Image.network(
        company.imagePath,
        height: 40.0,
        width: 40.0,
        fit: BoxFit.contain,
      );  

    }

  }

  Widget _itemNameCompany(Company company) {
    return Center(
      child: Text(
        company.label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }
}