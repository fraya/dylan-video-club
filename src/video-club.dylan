Module: video-club-impl

define constant <category>
  = one-of(#"childrens", #"regular", #"new-release");

define class <movie> (<object>)
  constant slot movie-title :: <string>,
    required-init-keyword: title:;
  constant slot movie-category :: <category>,
    required-init-keyword: category:;
end;

define constant <days>
  = limited(<integer>, min: 1);

define class <rental> (<object>)
  constant slot rental-movie :: <movie>,
    required-init-keyword: movie:;
  constant slot rental-rented :: <days> = 1,
    init-keyword: rented:;
end;

define constant <rentals> =
  limited(<vector>, of: <rental>);

define class <customer> (<object>)
  constant slot customer-name :: <string>,
    required-init-keyword: name:;
  slot customer-rentals :: <rentals> = make(<rentals>),
    init-keyword: rentals:;
end;

define method add-rental!
    (customer :: <customer>, rental :: <rental>)
 => (customer :: <customer>)
  customer.customer-rentals := add(customer.customer-rentals, rental);
  customer
end;