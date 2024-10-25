Module: video-club-impl

define class <customer> (<object>)
  constant slot customer-name :: <string>,
    required-init-keyword: name:;
  slot customer-rentals :: <rentals> = make(<rentals>, size: 0),
    init-keyword: rentals:;
end;

define method add-rental!
    (customer :: <customer>, rental :: <rental>)
 => (customer :: <customer>)
  customer.customer-rentals := add(customer.customer-rentals, rental);
  customer
end;
