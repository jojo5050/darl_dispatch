
import 'package:darl_dispatch/Admin/admin_load_reg_success_page.dart';
import 'package:darl_dispatch/Admin/am_newly_reg_loads_from_success_page.dart';
import 'package:darl_dispatch/Despatcher/dsp_load_reg_success_page.dart';
import 'package:darl_dispatch/Despatcher/dsp_newly_reg_load_from_successpage.dart';
import 'package:darl_dispatch/Despatcher/dsp_reg_load_with_pd_review.dart';
import 'package:darl_dispatch/GoogleMapManagers/tracking_input_field_page.dart';
import 'package:darl_dispatch/GoogleMapManagers/tracking_manager_page.dart';
import 'package:darl_dispatch/GoogleMapManagers/users_from_firebase.dart';
import 'package:darl_dispatch/LandingPageManagers/accountant_landing_page_manager.dart';
import 'package:darl_dispatch/LandingPageManagers/admin_landing_page_manager.dart';
import 'package:darl_dispatch/LandingPageManagers/driver_landing_manager.dart';
import 'package:darl_dispatch/Loads/admin_newly_reg_loads_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Admin/admin_manage_load_screen.dart';
import '../Admin/all_staffs.dart';
import '../Admin/driver_weekly_report.dart';
import '../Admin/manage_staff.dart';
import '../Admin/reg_new_user.dart';
import '../Admin/reports.dart';
import '../Admin/staff_due_for_payment.dart';
import '../Authentication/edit_profile.dart';
import '../Authentication/forgot_pass_confirm_tel.dart';
import '../Authentication/forgot_pass_enter_email.dart';
import '../Authentication/login_page.dart';
import '../Authentication/reset_pass_final.dart';
import '../Authentication/sign_up_page.dart';
import '../Despatcher/all_dispatchers.dart';
import '../Despatcher/despatcher_home_page.dart';
import '../Despatcher/dsp_delivered_loads_preview.dart';
import '../Despatcher/dsp_manage_loads.dart';
import '../Despatcher/dsp_registered_loads_preview.dart';
import '../Drivers/active_drivers.dart';
import '../Drivers/allDrivers.dart';
import '../Drivers/dr_available_vehicles.dart';
import '../Drivers/dr_delivered_loads_preview.dart';
import '../Drivers/dr_loads_assigned_preview.dart';
import '../Drivers/driver_edit_profile.dart';
import '../Drivers/drivers_management_screen.dart';
import '../Drivers/non_active_drivers.dart';
import '../General/clientProfilePage.dart';
import '../GoogleMapManagers/device_location_page.dart';
import '../LandingPageManagers/dispatcher_landing_page_manager.dart';
import '../Loads/add_drop_pickup.dart';
import '../Loads/admin_load_delivered_preview.dart';
import '../Loads/admin_reg_loads_with_pd_preview.dart';
import '../Loads/assign_load_from_pick_drop.dart';
import '../Loads/assign_load_to_driver.dart';
import '../Loads/drop_drops.dart';
import '../Loads/edit_reg_loads.dart';
import '../Loads/load_assigned_details.dart';
import '../Loads/loads_assigned_preview.dart';
import '../Loads/pick_pickup.dart';
import '../Loads/preview_reg_loads.dart';
import '../Loads/reassign_load_to_driver.dart';
import '../Loads/register_new_load.dart';
import '../Loads/registered_loads_main.dart';
import '../Loads/registered_pick_drop.dart';
import '../Onboaarding/initial_dashboard.dart';
import '../Onboaarding/splash_screen.dart';
import '../Vehicles/availabe_vehicles.dart';
import '../Vehicles/edit_vehicle.dart';
import '../Vehicles/reg_new_vehicle.dart';
import '../Vehicles/vehicle_management_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/general_user_dashboard':
      return MaterialPageRoute(builder: (_) => const DespatcherHomePage());
    case '/dispatcher_landingPage_manager':
      return MaterialPageRoute(builder: (_) => const DispatcherLandingPageManager());
    case '/driver_landing_manager':
      return MaterialPageRoute(builder: (_) => const DriverLandingManager());
    case '/admin_landing_manager':
      return MaterialPageRoute(builder: (_) => const AdminLandingPageManager());
    case '/accountant_landing_manager':
      return MaterialPageRoute(builder: (_) => const AccountantLandingPageManager());
    case '/initial_dashboard':
      return MaterialPageRoute(builder: (_) => const InitialDashboard());
    case '/am_reg_loads_with_pd_Preview':
      return MaterialPageRoute(builder: (_) => const AdminRegisteredWithPDLoadsPreview());
    case '/am_newly_reg_loads':
      return MaterialPageRoute(builder: (_) => const AdminNewlyRegLoadsPreview());
    case '/previewRegLoads':
      return MaterialPageRoute(builder: (_) => const PreviewLoadsToBeRegistered());
    case '/RegisteredLoadsMain':
      return MaterialPageRoute(builder: (_) => const RegisteredLoadsMain());

    case '/editProfile':
      return MaterialPageRoute(builder: (_) => const EditProfile());
    case '/login_page':
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case '/forgotPassTel':
      return MaterialPageRoute(builder: (_) => const ForgotPassConfirmTel());
    case '/forgotPassEmail':
      return MaterialPageRoute(builder: (_) => const ForgetPassEnterEmail());
    case '/resetPassFinal':
      return MaterialPageRoute(builder: (_) => const ResetPassFinal());
    case '/addDropPickup':
      return MaterialPageRoute(builder: (_) => const AddDropPickup());

    case '/sign_up_page':
      return MaterialPageRoute(builder: (_) => const SignUpPage());

    case '/vehicles':
      return MaterialPageRoute(builder: (_) => const Vehicles());

    case '/register_load':
      return MaterialPageRoute(builder: (_) => const RegisterLoad());

    case '/adminManageLoad':
      return MaterialPageRoute(builder: (_) => const AdminManageLoad());

    case '/clientProfilePage':
      return MaterialPageRoute(builder: (_) => const ClientProfilePage(staffInfo: {},));

    case '/loadsAssignedPreview':
      return MaterialPageRoute(builder: (_) => const LoadsAssignedPreview());
    case '/editVehicle':
      return MaterialPageRoute(builder: (_) => const EditVehicle());
    case '/availableVehicles':
      return MaterialPageRoute(builder: (_) => const AvailableVehicles());
    case '/editRegLoads':
      return MaterialPageRoute(builder: (_) => const EditRegisteredLoads());
    case '/assignloadsToDriver':
      return MaterialPageRoute(builder: (_) => AssignLoadToDriver());

    case '/assignloadsToFromPickUp':
      return MaterialPageRoute(builder: (_) => AssignLoadFromPickDrop());

    case '/driverEdithProfile':
      return MaterialPageRoute(builder: (_) => const DriverEditProfile());

    case '/allDrivers':
      return MaterialPageRoute(builder: (_) => const AllDrivers());
    case '/non_active_active':
      return MaterialPageRoute(builder: (_) => const NonActiveDrivers());
    case '/regNewUser':
      return MaterialPageRoute(builder: (_) => const RegisterNewUser());
    case '/regNewVehicle':
      return MaterialPageRoute(builder: (_) => const RegisterNewVehicle());
    case '/registeredPickDrop':
      return MaterialPageRoute(builder: (_) => const RegisteredPickDrop());

    case '/pickPickUp':
      return MaterialPageRoute(builder: (_) => const PickPickUp());
    case '/activeDrivers':
      return MaterialPageRoute(builder: (_) => const ActiveDrivers());

    case '/driverManagementScreen':
      return MaterialPageRoute(builder: (_) => const DriversManagementScreen());

    case '/dropDrops':
      return MaterialPageRoute(builder: (_) => const DropDrops());

    case '/loadsAssignedDetails':
      return MaterialPageRoute(builder: (_) => const LoadAssignedDetails());
    case '/splash_screen':
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case '/re_assign_load':
      return MaterialPageRoute(builder: (_) => const ReAssignLoadToDriver());
    case '/dsp_registered_loads_preview':
      return MaterialPageRoute(builder: (_) => const DspRegisteredLoadsPreview());
    case '/dsp_reg_loads_with_pd_preview':
      return MaterialPageRoute(builder: (_) => const DspRegisteredWithPDLoadsPreview());

    case '/manage_staff':
      return MaterialPageRoute(builder: (_) => const AdminManageStaff());
    case '/all_users':
      return MaterialPageRoute(builder: (_) => const AllStaffs());
    case '/staff_due_for_pay':
      return MaterialPageRoute(builder: (_) => const StaffDueForPayment());
    case '/reports':
      return MaterialPageRoute(builder: (_) => const Reports());
    case '/drivers_weekly_reports':
      return MaterialPageRoute(builder: (_) => const DriverWeeklyReports());
    case '/dsp_manage_loads':
      return MaterialPageRoute(builder: (_) => const DspManageLoad());
    case '/dsp_delivered_preview':
      return MaterialPageRoute(builder: (_) => const DspLoadDeliveredPreview());

    case '/allDispatchers':
      return MaterialPageRoute(builder: (_) => const AllDispatchers());
    case '/drAvailableVehicles':
      return MaterialPageRoute(builder: (_) => const DrAvailableVehicles());
    case '/drLoadAssignedPreview':
      return MaterialPageRoute(builder: (_) => const DrLoadsAssignedPreview());
    case '/drLoadDeliveredPreview':
      return MaterialPageRoute(builder: (_) => const DrLoadDeliveredPreview());
    case '/adminLoadDeliveredPreview':
      return MaterialPageRoute(builder: (_) => const AdminLoadDeliveredPreview());
    case '/adminRegLoadSuccessPage':
      return MaterialPageRoute(builder: (_) => const AdminRegLoadSuccessPage());
    case '/dspRegLoadSuccessPage':
      return MaterialPageRoute(builder: (_) => const DspRegLoadSuccessPage());
    case '/amRegLoadsFromSuccess':
      return MaterialPageRoute(builder: (_) => const AdminNewlyRegLoadsFromSuccess());
    case '/dspRegLoadsFromSuccess':
      return MaterialPageRoute(builder: (_) => const DspNewlyRegLoadsFromSucess());
    case '/usersFromFirebase':
      return MaterialPageRoute(builder: (_) => const UsersFromFirebase());
    case '/trackingManagerPage':
      return MaterialPageRoute(builder: (_) => const TrackingManagerPage());
    case '/deviceTrackingInputField':
      return MaterialPageRoute(builder: (_) => const DeviceTrackingInputFieldPage());


    default:
      return MaterialPageRoute(builder: (_) => Container());
  }
}