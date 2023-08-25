class User {
  int? id;
  String? firstName;
  String? lastName;
  String? mobile_del_code;
  String? email;
  String? mobile;
  String? avatar;
  String? dob;
  String? warehouse;
  String? blood_group;
  String? commission;
  String? email_address;
  String? pin_code;
  String? availability_status;
  String? status;
  String? address;
  String? city;
  String? country;
  String? in_active;
  String? zip_code;
  String? state;
  String? vehicle_name;
  String? owner_name;
  String? vehicle_color;
  String? vehicle_registration_no;
  String? vehicle_details;
  String? driving_license_no;
  String? vehicle_rc_book_no;
  String? account_name;
  String? account_number;
  String? gpay_number;
  String? bank_address;
  String? ifsc_code;
  String? branch_name;
  String? deleted_at;
  String? created_at;
  String? updated_at;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobile_del_code,
        this.email,
        this.mobile,
        this.avatar,
        this.dob,
        this.warehouse,
        this.blood_group,
        this.commission,
        this.email_address,
        this.pin_code,
        this.availability_status,
        this.status,
        this.address,
        this.city,
        this.country,
        this.in_active,
        this.zip_code,
        this.state,
        this.vehicle_name,
        this.owner_name,
        this.vehicle_color,
        this.vehicle_registration_no,
        this.vehicle_details,
        this.driving_license_no,
        this.vehicle_rc_book_no,
        this.account_name,
        this.account_number,
        this.gpay_number,
        this.bank_address,
        this.ifsc_code,
        this.branch_name,
        this.deleted_at,
        this.created_at,
        this.updated_at,
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile_del_code = json['mobile_del_code'];
    email = json['email'];
    mobile = json['phone_number'];
    avatar = json['avatar'];
    dob = json['dob'];
    warehouse = json['warehouse'];
    blood_group = json['blood_group'];
    commission = json['commission'];
    email_address = json['email_address'];
    pin_code = json['pin_code'];
    availability_status = json['availability_status'];
    status = json['status'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    in_active = json['in_active'];
    zip_code = json['zip_code'];
    state = json['state'];
    vehicle_name = json['vehicle_name'];
    owner_name = json['owner_name'];
    vehicle_color = json['vehicle_color'];
    vehicle_registration_no = json['vehicle_registration_no'];
    vehicle_details = json['vehicle_details'];
    driving_license_no = json['driving_license_no'];
    vehicle_rc_book_no = json['vehicle_rc_book_no'];
    account_name = json['account_name'];
    account_number = json['account_number'];
    gpay_number = json['gpay_number'];
    bank_address = json['bank_address'];
    ifsc_code = json['ifsc_code'];
    branch_name = json['branch_name'];
    deleted_at = json['deleted_at'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile_del_code'] = mobile_del_code;
    data['email'] = email;
    data['mobile'] = mobile;
    data['avatar'] = avatar;
    data['dob'] = dob;
    data['warehouse'] = warehouse;
    data['blood_group'] = blood_group;
    data['commission'] = commission;
    data['email_address'] = email_address;
    data['pin_code'] = pin_code;
    data['availability_status'] = availability_status;
    data['status'] = status;
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    data['in_active'] = in_active;
    data['zip_code'] = zip_code;
    data['state'] = state;
    data['vehicle_name'] = vehicle_name;
    data['owner_name'] = owner_name;
    data['vehicle_color'] = vehicle_color;
    data['vehicle_registration_no'] = vehicle_registration_no;
    data['vehicle_details'] = vehicle_details;
    data['driving_license_no'] = driving_license_no;
    data['vehicle_rc_book_no'] = vehicle_rc_book_no;
    data['account_name'] = account_name;
    data['account_number'] = account_number;
    data['gpay_number'] = gpay_number;
    data['bank_address'] = bank_address;
    data['ifsc_code'] = ifsc_code;
    data['branch_name'] = branch_name;
    data['deleted_at'] = deleted_at;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    return data;
  }
}