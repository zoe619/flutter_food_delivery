import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/data/data.dart';
import 'package:flutter_food_delivery/models/restaurant.dart';
import 'package:flutter_food_delivery/screens/cart_screen.dart';
import 'package:flutter_food_delivery/screens/restaurant_screen.dart';
import 'package:flutter_food_delivery/widgets/rating_stars.dart';
import 'package:flutter_food_delivery/widgets/recent_orders.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{

  _buildRestaurants(){

     List<Widget> restaurantList = [];
     restaurants.forEach((Restaurant restaurant){
        restaurantList.add(
          GestureDetector(
            onTap: ()=>Navigator.push(context,
                MaterialPageRoute(
              builder: (_)=>RestaurantScreen(restaurant: restaurant),
            )),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey[200],
                )
              ),
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: restaurant.imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image(
                        height: 150.0,
                        width: 150.0,
                        image: AssetImage(restaurant.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                           Text(restaurant.name, style: TextStyle(
                             fontSize: 20.0,
                             fontWeight: FontWeight.bold,
                            ),
                           ),
                        RatingStars(restaurant.rating),
                        SizedBox(height: 6.0),
                           Text(restaurant.address, style: TextStyle(
                             fontSize: 16.0,
                             fontWeight: FontWeight.w600,

                           ),
                             softWrap: true,
                             overflow: TextOverflow.ellipsis,
                             maxLines: 1,
                           ),
                          Text('0.2 miles away')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        );
     });
     return Column(
       children: restaurantList);
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          iconSize: 30.0,
          onPressed: (){},
        ),
        title: Center(child: Text('Food Delivery')),
       actions: <Widget>[
         FlatButton(
           child: Text('Cart ${currentUser.cart.length}', style: TextStyle(
              fontSize: 20.0,
              color: Colors.white
           ),
           ),
           onPressed: ()=> Navigator.push(context, MaterialPageRoute(
             builder: (_)=>CartScreen()
           )),
         )
       ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(width: 0.8, color: Theme.of(context).primaryColor)
                ),
                hintText: ('Search Food or Restaurants'),
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                ),
                suffixIcon: IconButton(
                 icon: Icon(Icons.clear),
                  iconSize: 30.0,
                  onPressed: (){},
                )
              ),
            ),
          ),
          RecentOrders(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 1.0),
                child: Text('Nearby Restaurants', style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),),
              ),
              _buildRestaurants(),
            ],
          )
        ],
      ),
    );
  }
}
