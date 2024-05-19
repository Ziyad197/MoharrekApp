
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moharrek/pages/auth/controller/auth_controller.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/pages/home/model/bidding.dart';
import 'package:moharrek/pages/home/model/car.dart';
import 'package:moharrek/shared_pref.dart';
import 'package:moharrek/widget/action_price_dropdownmenu.dart';
import 'package:moharrek/widget/auction_widget.dart';
import 'package:moharrek/components/button.dart';

class AuctionCarDetailPage extends GetWidget<CarController> {
  GlobalKey<FormState> fState = GlobalKey();
  TextEditingController bidAmount = TextEditingController();
  var formatter = NumberFormat();

  final Car _car = Get.arguments;



  String formattedDate(String dateTime) {
    var format = DateFormat.yMd('en_US');
    return format.format(DateTime.parse(dateTime));
  }
  bool isExpire(String expire){
    return DateTime.parse(expire).isBefore(DateTime.now());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: Text('Title'),
            ),
        body: StreamBuilder<Car?>(
          stream: controller.getCarByIdStream(_car),
          builder: (context, snapshot) {
            Car car = snapshot.data??_car;
            if(snapshot.hasData){
              _car.auctions.sort((a, b) => b.amount.compareTo(a.amount),);
            }
            controller.price(car.price);
            bool isLastMe =car.auctions.isNotEmpty?car.auctions[car.auctions.length-1].participantId==Preference.shared.getUserId():false;
            return snapshot.connectionState!=ConnectionState.waiting? ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                CustomAuctionCarDetailHeader(
                    make: car.make, model: car.model, year: car.year, carImages: car.images),
                const SizedBox(height: 10),
                CustomAuctionInfoCard(
                  stream: controller.getCarByIdStream(_car)
                ),
                const SizedBox(height: 10),

                AuctionBidders(actions: car.auctions),
                const SizedBox(height: 10),
                Visibility(
                    visible: status(car)=='الشراء',
                    child: const Center(child: Text('أنت الفائز'))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomeButton(
                      text: status(car),
                      color: isExpire(car.expireDate)?Colors.red:isLastMe?Colors.grey:Colors.blue,
                      height: 5,
                      onPressed: () async{

                        if(status(car)=='الشراء'){
                          Get.snackbar('تم الشراء', 'تمت عملية الشراء بنجاح');
                          await controller.updateCarPaymentStatus(car.carId,true,Preference.shared.getUserId()!);
                          //here show dialog with lottie and message paid success
                        }else if(status(car)=='حظر المستخدم'){
                          car.auctions.sort((a, b) => b.amount.compareTo(a.amount),);
                          Get.find<AuthController>().blockUser(car.auctions[0].participantId);
                        }else if(status(car)=='انتهت المزايدة'){
                          Get.snackbar('انتهت المزايدة', 'لأيمكنك المزايدة');
                        }else if(status(car)=='تم الشراء'){
                          Get.snackbar('انتهت المزايدة', 'لأيمكنك المزايدة');
                        }else if(!isLastMe){
                          var pr = car.auctions.isEmpty?controller.price.value:controller.limitAuctionPrice.value;
                          await controller.addAuction(
                              Auction(carId: _car.carId,
                                  participantId: Preference.shared.getUserId()!,
                                  participantName: Preference.shared.getUserName()!,
                                  amount: (pr+_car.bidPrice),
                                  date: DateTime.now().toString(),
                                  expiryDate: DateTime.now())
                          );
                        }else{
                          Get.snackbar(
                            "أنت آخر مزايد", // Arabic translation for "Last One is You"
                            "لا يمكنك المزايدة", // Arabic translation for "Can not add"
                          );
                        }
                        // isExpire(car.expireDate)?null:openDialog(context,car.price);
                      },
                      isLoading: false),
                )
              ],
            ):const Center(child: CircularProgressIndicator());
          }
        ));
  }
  String status(Car car) {
    // 1. Check if user is participant in the highest auction and car is expired but not paid
    if (isExpire(car.expireDate) && car.paid == false && isHighestAuctionParticipant(car)) {
      return 'الشراء';
    }

    // 2. Check if car is already purchased
    if (car.paid == true) {
      return 'تم الشراء';
    }

    if(car.paid==false && isExpire(car.expireDate) && Preference.shared.getAdmin()!){
      return 'حظر المستخدم';
    }

    // 3. Check if car's expiry date has passed
    if (isExpire(car.expireDate)) {
      return 'انتهت المزايدة';
    }

    // 4. Default case: car is active for bidding
    return 'مزايدة';
  }

  bool isHighestAuctionParticipant(Car car) {
    if (car.auctions.isEmpty) {
      return false; // No auctions, so no highest participant
    }

    int highestAmountIndex = 0;
    for (int i = 1; i < car.auctions.length; i++) {
      if (car.auctions[i].amount > car.auctions[highestAmountIndex].amount) {
        highestAmountIndex = i;
      }
    }


    return car.auctions[highestAmountIndex].participantId == Preference.shared.getUserId();
  }

}

class AuctionBidders extends StatefulWidget {
  // final List<String> bidders;
  final List<Auction> actions;
  const AuctionBidders({
    super.key,
    required this.actions,
  });


  @override
  State<AuctionBidders> createState() => _AuctionBiddersState();
}

class _AuctionBiddersState extends State<AuctionBidders> {
  int count = 0;
  var formatter = NumberFormat();

  @override
  Widget build(BuildContext context) {
    widget.actions.sort((a, b) => b.amount.compareTo(a.amount),);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1, color: Colors.orange),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const Text(
            "قائمة المزايدين",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 210,
            child: ListView.builder(
              itemCount: widget.actions.length,
              itemBuilder: (context, index) {
                count++;
                bool isMe = widget.actions[index].participantId == Preference.shared.getUserId();
                String userName = isMe?widget.actions[index].participantName:"مستخدم";
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        index == 0
                            ? const Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              )
                            : Text("${index+1}"),
                        const SizedBox(
                          width: 10,
                        ),
                        index == 0
                            ? Text(userName,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange))
                            : Text(userName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                      ],
                    ),
                    index==0
                        ? Text(
                            "${formatter.format(widget.actions[index].amount)} ر.س",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange))
                        : Text(
                            "${formatter.format(widget.actions[index].amount)} ر.س",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ))
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
