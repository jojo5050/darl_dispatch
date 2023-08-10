
import 'package:darl_dispatch/AuthManagers/api_services.dart';
import 'package:dio/dio.dart';

class AuthRepo with ApiServices{

  Future<Response?> register(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("create_user.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> login(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("login.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> updateUserInfo(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("update_user.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getSingleUserInfo(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("user_info.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }


  Future<Response?> resetPassWithEmail(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("forgot_password_1.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> resetPassWithTel(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("forgot_password_2.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> resetPassFinal(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("forgot_password_3.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> registerLoad(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/register_load.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> addPickup(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/add_pickup.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> addDrop(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/add_drop.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> fetchAllRegLoads() async {
    Response? response = await apiGetRequests("admin/registered_load.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getAllUsers() async {
    Response? response = await apiGetRequests("admin/registered_users.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getAllDispatchers() async {
    Response? response = await apiGetRequests("admin/registered_Dispatchers.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getAllAssignedLoads() async {
    Response? response = await apiGetRequests("admin/loads_assigned.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> staffDueForPay() async {
    Response? response = await apiGetRequests("admin/staffDueForPayment.php");

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> driverPayroll() async {
    Response? response = await apiGetRequests("admin/driversWeeklyPayroll.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getAllVehicles() async {
    Response? response = await apiGetRequests("admin/registered_vehicles.php");

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> activeVehicles() async {
    Response? response = await apiGetRequests("admin/active_vehicles.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> allDrivers() async {
    Response? response = await apiGetRequests("admin/registered_drivers.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> activeDrivers() async {
    Response? response = await apiGetRequests("admin/active_drivers.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> nonActiveDrivers() async {
    Response? response = await apiGetRequests("admin/non_active_drivers.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getVehicleDetail(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/vehicle_detail.php", credentials );

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> registerNewVehicle(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/vehicle_registration.php", credentials );

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> fetchSingleLoad(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/load_details.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> createNewUser(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/users_registration.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }


  Future<Response?> deletVehicle(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/admin_delete_vehicle.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }


  Future<Response?> deletLoad(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/delete_load.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> deletStaff(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/admin_delete_user.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> updateRegLoads(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/edit_load.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> updateVehicle(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/vehicle_update.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getPickups(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/registered_pickups.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getDrops(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/registered_drops.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> assignLoad(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/assign_load.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> pickLoad(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("drivers/pickLoad.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> dropLoad(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("drivers/dropLoad.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> uploadImage(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("profile_picture.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getAllTrucks() async {
    Response? response = await apiGetRequests("admin/registered_trucks.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getAllTrailers() async {
    Response? response = await apiGetRequests("admin/registered_trailer.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> companyDetails() async {
    Response? response = await apiGetRequests("admin/companyInfo.php");

    if (response != null) {
      return response;
    }

    return null;
  }


  Future<Response?> loadAssignedDetails(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/loadsAssigned.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> reAssignLoad(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/re-assign_load.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> drAssignedLoad(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("drivers/loads_assigned.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> drDeliveredLoad(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("drivers/loads_delivered.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }


  Future<Response?> dspRegLoad(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("Despatchers/registered_load.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> dspDeliveredLoads(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("Despatchers/loads_delivered_list.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> dspAssignedLoad(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("Despatchers/loads_assigned.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> getAssignedTruck(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/load_vehicles_truck.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> getAssignedTrailer(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/load_vehicles_trailer.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> getAssignedTractor(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/load_vehicles_tractor.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getAssignedDrops(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("drivers/Drops_assigned.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getAssignedPickups(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("drivers/pickups_assigned.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getSingleLoadDetails(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/load_details.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> vehicleIncome(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("accountant/vehicle_income.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getBol(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("drivers/bol/get_bol.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> deleteDrop(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/admin_delete_drop.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> deletePickup(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/admin_delete_pickup.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> updatePickup(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/admin_edit_pickup.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> updateDrop(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("admin/admin_edit_drop.php", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getCompanyIncome() async {
    Response? response = await apiGetRequests("accountant/company_income.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> staffsDue() async {
    Response? response = await apiGetRequests("accountant/staff_due_for_payment.php");

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> driversDue() async {
    Response? response = await apiGetRequests("accountant/drivers_due_for_payment.php");

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> driversPaid() async {
    Response? response = await apiGetRequests("accountant/drivers_successfully_paid.php");

    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> staffsPaid() async {
    Response? response = await apiGetRequests("accountant/staff_successfully_paid.php");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> getPaidLoads() async {
    Response? response = await apiGetRequests("accountant/paid_pickups.php");

    if (response != null) {
      return response;
    }

    return null;
  }


}