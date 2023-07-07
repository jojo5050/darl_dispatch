import 'package:flutter/cupertino.dart';
  class LoadRegistrationModel {

    TextEditingController rateConfirmController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController loadDiscrController = TextEditingController();

    TextEditingController brokerNameController = TextEditingController();
    TextEditingController brokerEmailController = TextEditingController();
    TextEditingController brokerPhoneController = TextEditingController();

    TextEditingController shipperEmailController = TextEditingController();
    TextEditingController shipperAddressController = TextEditingController();

    final GlobalKey<FormState> loadRegFormKey = GlobalKey<FormState>();

}