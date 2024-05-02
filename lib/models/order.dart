// ignore_for_file: non_constant_identifier_names

class OrdersData {
  int? orderId;
  CustomerId? customerId;
  String? warehouseId;
  WareHouse? warehouse;
  DeliveryBoy? deliveryboy;
  String? order_from;
  String? billing_first_name;
  String? billing_last_name;
  String? billing_company;
  String? billing_street_aadress;
  String? billing_suburb;
  String? billing_city;
  String? billing_postcode;
  String? billing_country;
  String? billing_state;
  String? billing_phone;
  String? delivery_first_name;
  String? delivery_last_name;
  String? delivery_dt;
  String? delivery_time;
  String? delivery_company;
  String? delivery_street_aadress;
  String? delivery_suburb;
  String? delivery_city;
  String? delivery_postcode;
  String? delivery_country;
  String? delivery_state;
  String? delivery_phone;
  String? cc_type;
  String? cc_owner;
  String? cc_number;
  String? cc_expiry;
  String? currency_value;
  String? order_price;
  String? shipping_cost;
  String? shipping_method;
  String? shipping_duration;
  String? customer_order_notes;
  String? is_seen;
  String? coupon_code;
  String? coupon_amount;
  String? payment_method;
  String? transaction_id;
  String? order_status;
  String? delivery_status;
  String? delivery_boy_id;
  String? total_tax;
  String? order_date;
  String? order_time;
  String? latlong;
  String? transaction_fee;
  List<OrderHistory>? order_history;
  List<OrderNotes>? order_notes;
  List<OrderComments>? order_comments;
  List<OrderDetail>? orderDetail;

  OrdersData({
    this.orderId,
    this.customerId,
    this.warehouseId,
    this.warehouse,
    this.deliveryboy,
    this.order_from,
    this.billing_first_name,
    this.billing_last_name,
    this.billing_company,
    this.billing_street_aadress,
    this.billing_suburb,
    this.billing_city,
    this.billing_postcode,
    this.billing_country,
    this.billing_state,
    this.billing_phone,
    this.delivery_first_name,
    this.delivery_last_name,
    this.delivery_dt,
    this.delivery_time,
    this.delivery_company,
    this.delivery_street_aadress,
    this.delivery_suburb,
    this.delivery_city,
    this.delivery_postcode,
    this.delivery_country,
    this.delivery_state,
    this.delivery_phone,
    this.cc_type,
    this.cc_owner,
    this.cc_number,
    this.cc_expiry,
    this.currency_value,
    this.order_price,
    this.shipping_cost,
    this.shipping_method,
    this.shipping_duration,
    this.customer_order_notes,
    this.is_seen,
    this.coupon_code,
    this.coupon_amount,
    this.payment_method,
    this.transaction_id,
    this.order_status,
    this.delivery_status,
    this.delivery_boy_id,
    this.total_tax,
    this.order_date,
    this.order_time,
    this.latlong,
    this.transaction_fee,
    this.order_history,
    this.order_notes,
    this.order_comments,
    this.orderDetail
  });

  OrdersData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    customerId =
        json['customer_id'] != null ? CustomerId.fromJson(json['customer_id']) : null;
    warehouseId = json['warehouse_id'].toString();
    warehouse = json['warehouse'] != null
        ? WareHouse.fromJson(json['warehouse'])
        : null;
    deliveryboy = json['deliveryboy'] != null
        ? DeliveryBoy.fromJson(json['deliveryboy'])
        : null;
    order_from = json['order_from'].toString();
    billing_first_name = json['billing_first_name'].toString();
    billing_last_name = json['billing_last_name'].toString();
    billing_company = json['billing_company'].toString();
    billing_street_aadress = json['billing_street_aadress'].toString();
    billing_suburb = json['billing_suburb'].toString();
    billing_city = json['billing_city'].toString();
    billing_postcode = json['billing_postcode'].toString();
    billing_country = json['billing_country'].toString();
    billing_state = json['billing_state'].toString();
    billing_phone = json['billing_phone'].toString();
    delivery_first_name = json['delivery_first_name'].toString();
    delivery_last_name = json['delivery_last_name'].toString();
    delivery_dt = json['delivery_dt'].toString();
    delivery_time = json['delivery_time'].toString();
    delivery_company = json['delivery_company'].toString();
    delivery_suburb = json['delivery_suburb'].toString();
    billing_city = json['delivery_city'].toString();
    billing_postcode = json['delivery_postcode'].toString();
    billing_country = json['delivery_country'].toString();
    billing_state = json['delivery_state'].toString();
    billing_phone = json['delivery_phone'].toString();
    cc_type = json['cc_type'].toString();
    cc_owner = json['cc_owner'].toString();
    cc_number = json['cc_number'].toString();
    cc_expiry = json['cc_expiry'].toString();
    currency_value = json['currency_value'].toString();
    order_price = json['order_price'].toString();
    shipping_cost = json['shipping_cost'].toString();
    shipping_method = json['shipping_method'].toString();
    shipping_duration = json['shipping_duration'].toString();
    customer_order_notes = json['customer_order_notes'].toString();
    is_seen = json['is_seen'].toString();
    coupon_code = json['coupon_code'].toString();
    coupon_amount = json['coupon_amount'].toString();
    payment_method = json['payment_method'].toString();
    transaction_id = json['transaction_id'].toString();
    order_status = json['order_status'].toString();
    delivery_status = json['delivery_status'].toString();
    delivery_boy_id = json['delivery_boy_id'].toString();
    total_tax = json['total_tax'].toString();
    order_date = json['order_date'].toString();
    order_time = json['order_time'].toString();
    latlong = json['latlong'].toString();
    transaction_fee = json['transaction_fee'].toString();
    if (json['order_history'] != null) {
      order_history = <OrderHistory>[];
      json['order_history'].forEach((v) {
        order_history?.add(OrderHistory.fromJson(v));
      });
    }
    if (json['order_notes'] != null) {
      order_notes = <OrderNotes>[];
      json['order_notes'].forEach((v) {
        order_notes?.add(OrderNotes.fromJson(v));
      });
    }
    if (json['order_comments'] != null) {
      order_comments = <OrderComments>[];
      json['order_comments'].forEach((v) {
        order_comments?.add(OrderComments.fromJson(v));
      });
    }
    if (json['order_detail'] != null) {
      orderDetail = <OrderDetail>[];
      json['order_detail'].forEach((v) {
        orderDetail?.add(OrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    if (customerId != null) {
      data['customer_id'] = customerId?.toJson();
    }
    data['warehouse_id'] = warehouseId;
    if (warehouse != null) {
      data['warehouse'] = warehouse?.toJson();
    }
    if (deliveryboy != null) {
      data['deliveryboy'] = deliveryboy?.toJson();
    }
    data['order_from'] = order_from;
    data['billing_first_name'] = billing_first_name;
    data['billing_last_name'] = billing_last_name;
    data['billing_company'] = billing_company;
    data['billing_street_aadress'] = billing_street_aadress;
    data['billing_suburb'] = billing_suburb;
    data['billing_city'] = billing_city;
    data['billing_postcode'] = billing_postcode;
    data['billing_country'] = billing_country;
    data['billing_state'] = billing_state;
    data['billing_phone'] = billing_phone;
    data['delivery_first_name'] = delivery_first_name;
    data['delivery_last_name'] = delivery_last_name;
    data['delivery_dt'] = delivery_dt;
    data['delivery_time'] = delivery_time;
    data['delivery_company'] = delivery_company;
    data['delivery_suburb'] = delivery_suburb;
    data['delivery_city'] = delivery_city;
    data['delivery_postcode'] = delivery_postcode;
    data['delivery_country'] = delivery_country;
    data['delivery_state'] = delivery_state;
    data['delivery_phone'] = delivery_phone;
    data['cc_type'] = cc_type;
    data['cc_owner'] = cc_owner;
    data['cc_number'] = cc_number;
    data['cc_expiry'] = cc_expiry;
    data['currency_value'] = currency_value;
    data['order_price'] = order_price;
    data['shipping_cost'] = shipping_cost;
    data['shipping_method'] = shipping_method;
    data['shipping_duration'] = shipping_duration;
    data['customer_order_notes'] = customer_order_notes;
    data['is_seen'] = is_seen;
    data['coupon_code'] = coupon_code;
    data['coupon_amount'] = coupon_amount;
    data['payment_method'] = payment_method;
    data['transaction_id'] = transaction_id;
    data['order_status'] = order_status;
    data['delivery_status'] = delivery_status;
    data['delivery_boy_id'] = delivery_boy_id;
    data['total_tax'] = total_tax;
    data['order_date'] = order_date;
    data['order_time'] = order_time;
    data['latlong'] = latlong;
    data['transaction_fee'] = transaction_fee;
    if (order_history != null) {
      data['order_history'] = order_history?.map((v) => v.toJson()).toList();
    }
    if (order_notes != null) {
      data['order_notes'] = order_notes?.map((v) => v.toJson()).toList();
    }
    if (order_comments != null) {
      data['order_comments'] = order_comments?.map((v) => v.toJson()).toList();
    }
    if (orderDetail != null) {
      data['order_detail'] = orderDetail?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class CustomerId {
  int? customer_id;
  String? customer_first_name;
  String? customer_last_name;
  String? customer_email;
  String? customer_hash;
  String? customer_proof;
  String? customer_doctor;
  String? is_seen;
  String? customer_status;
  List<CustomerAddress>? customer_address;

  CustomerId({
    this.customer_id,
    this.customer_first_name,
    this.customer_last_name,
    this.customer_email,
    this.customer_hash,
   this.customer_proof,
   this.customer_doctor,
    this.is_seen,
    this.customer_status,
    this.customer_address,
  });

  CustomerId.fromJson(Map<String, dynamic> json) {
    customer_id = json['customer_id'];
    customer_first_name = json['customer_first_name'];
    customer_last_name = json['customer_last_name'];
    customer_email = json['customer_email'];
    customer_hash = json['customer_hash'];
   customer_proof = json['customer_proof'];
   customer_doctor = json['customer_doctor'];
    is_seen = json['is_seen'];
    customer_status = json['customer_status'];
    if (json['customer_address'] != null) {
      customer_address = <CustomerAddress>[];
      json['customer_address'].forEach((v) {
        customer_address?.add(CustomerAddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customer_id;
    data['customer_first_name'] = customer_first_name;
    data['customer_last_name'] = customer_last_name;
    data['customer_email'] = customer_email;
    data['customer_hash'] = customer_hash;
   data['customer_proof'] = customer_proof;
   data['customer_doctor'] = customer_doctor;
    data['is_seen'] = is_seen;
    data['customer_status'] = customer_status;
    if (customer_address != null) {
      data['customer_address'] =
          customer_address?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerAddress {
  int? id;
  String? first_name;
  String? last_name;
  String? gender;
  String? company;
  String? street_address;
  String? suburb;
  String? phone;
  String? postcode;
  String? dob;
  String? city;
  CountryId? country_id;
  StateId? state_id;
  String? lattitude;
  String? longitude;
  String? latlong;
  String? default_address;

  CustomerAddress({
    this.id,
    this.first_name,
    this.last_name,
    this.gender,
    this.company,
    this.street_address,
    this.suburb,
    this.phone,
    this.postcode,
    this.dob,
    this.city,
    this.country_id,
    this.state_id,
    this.lattitude,
    this.longitude,
    this.latlong,
    this.default_address,
  });

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    gender = json['gender'].toString();
    company = json['company'];
    street_address = json['street_address'];
    suburb = json['suburb'].toString();
    phone = json['phone'];
    postcode = json['postcode'];
    dob = json['dob'].toString();
    city = json['city'];
    country_id =   json['country_id'] != null ? CountryId.fromJson(json['country_id']) : null;
    // if (json['country_id'] != null) {
    //   country_id = <CountryId>[];
    //   json['country_id'].forEach((v) {
    //     country_id?.add(CountryId.fromJson(v));
    //   });
    // }
    state_id =   json['state_id'] != null ? StateId.fromJson(json['state_id']) : null;
    // if (json['state_id'] != null) {
    //   state_id = <StateId>[];
    //   json['state_id'].forEach((v) {
    //     state_id?.add(StateId.fromJson(v));
    //   });
    // }
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    latlong = json['latlong'].toString();
    default_address = json['default_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['gender'] = gender;
    data['company '] = company;
    data['street_address'] = street_address;
    data['suburb'] = suburb;
    data['phone'] = phone;
    data['postcode'] = postcode;
    data['dob'] = dob;
    data['city'] = city;

    if (country_id != null) {
      data['country_id'] = country_id?.toJson();
    }
    if (state_id != null) {
      data['state_id'] = state_id?.toJson();
    }
    data['lattitude'] = lattitude;
    data['longitude'] = longitude;
    data['latlong'] = latlong;
    data['default_address'] = default_address;

    return data;
  }
}

class CountryId {
  int? country_id;
  String? country_name;
  String? iso_code_2;
  String? iso_code_3;
  String? address_format_id;
  String? country_code;
  String? status;

  CountryId({
    this.country_id,
    this.country_name,
    this.iso_code_2,
    this.iso_code_3,
    this.address_format_id,
    this.country_code,
    this.status,
  });

  CountryId.fromJson(Map<String, dynamic> json) {
    country_id = json['customer_id'];
    country_name = json['country_name'];
    iso_code_2 = json['iso_code_2'];
    iso_code_3 = json['iso_code_3'];
    address_format_id = json['address_format_id'];
    country_code = json['country_code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = country_id;
    data['country_name'] = country_name;
    data['iso_code_2'] = iso_code_2;
    data['iso_code_3'] = iso_code_3;
    data['address_format_id'] = address_format_id;
    data['country_code'] = country_code;
    data['status'] = status;

    return data;
  }
}

class StateId {
  int? id;
  String? name;
  String? country_id;
  String? status;

  StateId({
    this.id,
    this.name,
    this.country_id,
    this.status,
  });

  StateId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country_id = json['country_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = country_id;
    data['status'] = status;
    return data;
  }
}

class WareHouse {
  int? warehouse_id;
  String? warehouse_code;
  String? warehouse_name;
  String? warehouse_address;
  String? warehouse_phone;
  String? warehouse_email;
  String? warehouse_status;
  String? warehouse_state_id;
  String? warehouse_country_id;

  WareHouse({
    this.warehouse_id,
    this.warehouse_code,
    this.warehouse_name,
    this.warehouse_address,
    this.warehouse_phone,
    this.warehouse_email,
    this.warehouse_status,
    this.warehouse_state_id,
    this.warehouse_country_id,
  });

  WareHouse.fromJson(Map<String, dynamic> json) {
    warehouse_id = json['warehouse_id'];
    warehouse_code = json['warehouse_code'].toString();
    warehouse_name = json['warehouse_name'].toString();
    warehouse_address = json['warehouse_address'].toString();
    warehouse_phone = json['warehouse_phone'].toString();
    warehouse_email = json['warehouse_email'].toString();
    warehouse_status = json['warehouse_status'].toString();
    warehouse_state_id = json['warehouse_state_id'].toString();
    warehouse_country_id = json['warehouse_country_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['warehouse_id'] = warehouse_id;
    data['warehouse_code'] = warehouse_code;
    data['warehouse_name'] = warehouse_name;
    data['warehouse_address'] = warehouse_address;
    data['warehouse_phone'] = warehouse_phone;
    data['warehouse_email'] = warehouse_email;
    data['warehouse_status'] = warehouse_status;
    data['warehouse_state_id'] = warehouse_state_id;
    data['warehouse_country_id'] = warehouse_country_id;
    return data;
  }
}

class DeliveryBoy {
  int? id;
  String? first_name;
  String? last_name;
  String? email;
  String? phone_number;
  String? avatar;
  String? dob;
  String? blood_group;
  String? warehouse;
  String? commission;
  String? pin_code;
  String? status;
  String? availability_status;
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

  DeliveryBoy({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.phone_number,
    this.avatar,
    this.dob,
    this.blood_group,
    this.warehouse,
    this.commission,
    this.pin_code,
    this.status,
    this.availability_status,
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
  });

  DeliveryBoy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'].toString();
    last_name = json['last_name'].toString();
    email = json['email'].toString();
    phone_number = json['phone_number'].toString();
    avatar = json['avatar'].toString();
    dob = json['dob'].toString();
    blood_group = json['blood_group'].toString();
    warehouse = json['warehouse'].toString();
    commission = json['commission'].toString();
    pin_code = json['pin_code'].toString();
    status = json['status'].toString();
    availability_status = json['availability_status'].toString();
    address = json['address'].toString();
    city = json['city'].toString();
    country = json['country'].toString();
    in_active = json['in_active'].toString();
    zip_code = json['zip_code'].toString();
    state = json['state'].toString();
    vehicle_name = json['vehicle_name'].toString();
    owner_name = json['owner_name'].toString();
    vehicle_color = json['vehicle_color'].toString();
    vehicle_registration_no = json['vehicle_registration_no'].toString();
    vehicle_details = json['vehicle_details'].toString();
    driving_license_no = json['driving_license_no'].toString();
    vehicle_rc_book_no = json['vehicle_rc_book_no'].toString();
    account_name = json['account_name'].toString();
    account_number = json['account_number'].toString();
    gpay_number = json['gpay_number'].toString();
    bank_address = json['bank_address'].toString();
    ifsc_code = json['ifsc_code'].toString();
    branch_name = json['branch_name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['email'] = email;
    data['phone_number'] = phone_number;
    data['avatar'] = avatar;
    data['dob'] = dob;
    data['blood_group'] = blood_group;
    data['warehouse'] = warehouse;
    data['commission'] = commission;
    data['pin_code'] = pin_code;
    data['status'] = status;
    data['availability_status'] = availability_status;
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

    return data;
  }
}

class OrderHistory {
  int? id;
  String? order_id;
  String? order_status;
  String? created_at;
  String? updated_at;

  OrderHistory({
    this.id,
    this.order_id,
    this.order_status,
    this.created_at,
    this.updated_at,
  });

  OrderHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order_id = json['order_id'].toString();
    order_status = json['order_status'].toString();
    created_at = json['created_at'].toString();
    updated_at = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = order_id;
    data['order_status'] = order_status;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;

    return data;
  }
}

class OrderNotes {
  int? id;
  String? title;
  String? notes;
  String? order_id;
  String? created_at;
  String? updated_at;

  OrderNotes({
    this.id,
    this.title,
    this.notes,
    this.order_id,
    this.updated_at,
  });

  OrderNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    notes = json['notes'];
    order_id = json['order_id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['notes'] = notes;
    data['order_id'] = order_id;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;

    return data;
  }
}

class OrderComments {
  int? id;
  String? message;
  String? created_at;
  String? customer;
  User? user;

  OrderComments({
    this.id,
    this.message,
    this.created_at,
    this.customer,
    this.user,
  });

  OrderComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    created_at = json['created_at'];
    customer = json['customer'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['created_at'] = created_at;
    if (user != null) {
      data['user'] = user?.toJson();
    }

    return data;
  }
}

class User {
  int? u_id;
  String? name;
  String? email;
  String? status;
  Role? role;

  User({
    this.u_id,
    this.name,
    this.email,
    this.status,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    u_id = json['u_id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['u_id'] = u_id;
    data['name'] = name;
    data['email'] = email;
    data['status'] = status;
    if (role != null) {
      data['role'] = role?.toJson();
    }

    return data;
  }
}

class Role {
  int? id;
  String? name;

  Role({
    this.id,
    this.name,
  });

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
class OrderDetail {
  Product? product;
  var productPrice;
  String? productDiscount;
  var productTax;
  var productQty;
  var productTotal;

  OrderDetail(
      {this.product,
        this.productPrice,
        this.productDiscount,
        this.productTax,
        this.productQty,
        this.productTotal});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    productPrice = json['product_price'].toString();
    productDiscount = json['product_discount'].toString();
    productTax = json['product_tax'].toString();
    productQty = json['product_qty'].toString();
    productTotal = json['product_total'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product?.toJson();
    }
    data['product_price'] = productPrice;
    data['product_discount'] = productDiscount;
    data['product_tax'] = productTax;
    data['product_qty'] = productQty;
    data['product_total'] = productTotal;
    return data;
  }
}

class Product {
  int? productId;
  String? productType;
  String? productSlug;
  ProductGallary? productGallary;
  List<ProductGallaryDetail>? productGallaryDetail;
  var productPrice;
  var productDiscountPrice;
  String? productStatus;
  ProductBrand? productBrand;
  var isFeatured;
  String? isPoints;
  List<Detail>? detail;
  List<Reviews>? reviews;
  Stock? stock;

  Product(
      {this.productId,
        this.productType,
        this.productSlug,
        this.productGallary,
        this.productGallaryDetail,
        this.productPrice,
        this.productDiscountPrice,
        this.productStatus,
        this.productBrand,
        this.isFeatured,
        this.isPoints,
        this.detail,
        this.reviews,
        this.stock});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productType = json['product_type'].toString();
    productSlug = json['product_slug'].toString();
    productGallary = json['product_gallary'] != null
        ? ProductGallary.fromJson(json['product_gallary'])
        : null;
    if (json['product_gallary_detail'] != null) {
      productGallaryDetail = <ProductGallaryDetail>[];
      json['product_gallary_detail'].forEach((v) {
        productGallaryDetail?.add(ProductGallaryDetail.fromJson(v));
      });
    }
    productPrice = json['product_price'].toString();
    productDiscountPrice = json['product_discount_price'].toString();
    productStatus = json['product_status'].toString();
    productBrand = json['product_brand'] != null
        ? ProductBrand.fromJson(json['product_brand'])
        : null;
    isFeatured = json['is_featured'].toString();
    isPoints = json['is_points'].toString();
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail?.add(Detail.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews?.add(Reviews.fromJson(v));
      });
    }
    stock = json['stock'] != null ? Stock.fromJson(json['stock']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_type'] = productType;
    data['product_slug'] = productSlug;
    if (productGallary != null) {
      data['product_gallary'] = productGallary?.toJson();
    }
    if (productGallaryDetail != null) {
      data['product_gallary_detail'] =
          productGallaryDetail?.map((v) => v.toJson()).toList();
    }
    data['product_price'] = productPrice;
    data['product_discount_price'] = productDiscountPrice;
    data['product_status'] = productStatus;
    if (productBrand != null) {
      data['product_brand'] = productBrand?.toJson();
    }
    data['is_featured'] = isFeatured;
    data['is_points'] = isPoints;
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    if (stock != null) {
      data['stock'] = stock?.toJson();
    }
    return data;
  }
}

class ProductGallary {
  int? id;
  String? gallaryName;
  String? gallaryExtension;
  var userId;
  List<Detail>? detail;

  ProductGallary(
      {this.id,
        this.gallaryName,
        this.gallaryExtension,
        this.userId,
        this.detail});

  ProductGallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryName = json['gallary_name'].toString();
    gallaryExtension = json['gallary_extension'].toString();
    userId = json['user_id'].toString();
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail?.add(Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gallary_name'] = gallaryName;
    data['gallary_extension'] = gallaryExtension;
    data['user_id'] = userId;
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Detail {
  String? id;
  String? title;
  String? desc;
  Language? language;

  Detail(
      {this.id,
        this.title,
        this.desc,
        this.language});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['product_id'].toString();
    title = json['title'].toString();
    desc = json['desc'].toString();
    language =  json['language'] != null ? Language.fromJson(json['language']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    if (language != null) {
      data['language'] = language?.toJson();
    }
    return data;
  }
}

class ProductGallaryDetail {
  int? id;
  String? gallaryName;
  String? gallaryExtension;
  var userId;

  ProductGallaryDetail(
      {this.id, this.gallaryName, this.gallaryExtension, this.userId});

  ProductGallaryDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryName = json['gallary_name'].toString();
    gallaryExtension = json['gallary_extension'].toString();
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gallary_name'] = gallaryName;
    data['gallary_extension'] = gallaryExtension;
    data['user_id'] = userId;
    return data;
  }
}

class ProductBrand {
  int? brandId;
  String? brandName;
  String? brandSlug;
  Gallary? gallary;
  String? brandStatus;

  ProductBrand(
      {this.brandId,
        this.brandName,
        this.brandSlug,
        this.gallary,
        this.brandStatus});

  ProductBrand.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    brandSlug = json['brand_slug'];
    gallary =
    json['gallary'] != null ? Gallary.fromJson(json['gallary']) : null;
    brandStatus = json['brand_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_id'] = brandId;
    data['brand_name'] = brandName;
    data['brand_slug'] = brandSlug;
    if (gallary != null) {
      data['gallary'] = gallary?.toJson();
    }
    data['brand_status'] = brandStatus;
    return data;
  }
}

class Gallary {
  int? id;
  String? name;
  String? extension;
  var userId;
  var createdBy;
  var updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Gallary(
      {this.id,
        this.name,
        this.extension,
        this.userId,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Gallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    extension = json['extension'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['extension'] = extension;
    data['user_id'] = userId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Language {
  int? id;
  String? languageName;
  String? code;
  String? isDefault;
  String? direction;
  String? directory;
  String? status;

  Language(
      {this.id,
        this.languageName,
        this.code,
        this.isDefault,
        this.direction,
        this.directory,
        this.status,

      });

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageName = json['language_name'].toString();
    code = json['code'].toString();
    isDefault = json['is_default'].toString();
    direction = json['direction'].toString();
    directory = json['directory'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['language_name'] = languageName;
    data['code'] = code;
    data['is_default'] = isDefault;
    data['direction'] = direction;
    data['directory'] = directory;
    data['status'] = status;
    return data;
  }
}

class Reviews {
  int? id;
  String? comment;
  String? rating;
  String? status;

  Reviews({this.id, this.comment, this.rating, this.status});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'].toString();
    rating = json['rating'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['rating'] = rating;
    data['status'] = status;
    return data;
  }
}

class Stock {
  String? productId;
  String? productCombinationId;
  String? productType;
  String? warehouseId;
  String? stockIn;
  String? stockOut;
  String? remainingStock;
  String? price;
  String? discountPrice;

  Stock(
      {this.productId,
        this.productCombinationId,
        this.productType,
        this.warehouseId,
        this.stockIn,
        this.stockOut,
        this.remainingStock,
        this.price,
        this.discountPrice});

  Stock.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'].toString();
    productCombinationId = json['product_combination_id'].toString();
    productType = json['product_type'].toString();
    warehouseId = json['warehouse_id'].toString();
    stockIn = json['stock_in'].toString();
    stockOut = json['stock_out'].toString();
    remainingStock = json['remaining_stock'].toString();
    price = json['price'].toString();
    discountPrice = json['discount_price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_combination_id'] = productCombinationId;
    data['product_type'] = productType;
    data['warehouse_id'] = warehouseId;
    data['stock_in'] = stockIn;
    data['stock_out'] = stockOut;
    data['remaining_stock'] = remainingStock;
    data['price'] = price;
    data['discount_price'] = discountPrice;
    return data;
  }
}