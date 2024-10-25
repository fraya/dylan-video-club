Module: video-club-impl

define constant <price-code>
  = one-of(#"childrens", #"regular", #"new-release");

define class <movie> (<object>)
  constant slot movie-title :: <string>,
    required-init-keyword: title:;
  slot movie-price-code :: <price-code>,
    required-init-keyword: price-code:;
end;

define class <rental> (<object>)
  constant slot rental-movie :: <movie>,
    required-init-keyword: movie:;
  constant slot rental-days-rented :: <integer>,
    required-init-keyword: days-rented:;
end;

define class <customer> (<object>)
  constant slot customer-name :: <string>,
    required-init-keyword: name:;
  constant slot customer-rentals :: <sequence> = make(<stretchy-vector>),
    init-keyword: rentals:;
end;

define method add-rental!
    (customer :: <customer>, rental :: <rental>)
 => (customer :: <customer>)
  add!(customer.customer-rentals, rental);
  customer
end;

define function statement
    (customer :: <customer>)
 => (result :: <string>)
  with-output-to-string (stream)
    format(stream, "Rental Record for %s\n", customer.customer-name);
    for (rental in customer.customer-rentals)
      let movie  = rental.rental-movie;
      // show figures for this rental
      format(stream, "\t%30s\t%5d\n", movie.movie-title, rental.rental-charge);
    end for;

    // add footer lines
    format(stream, "Amount owed is %d\n", customer.customer-charge);
    format(stream, "You earned %d frequent renter points", customer.rental-frequent-points);
  end with-output-to-string;
end statement;

define function rental-charge
    (rental :: <rental>) => (amount :: <float>)
  rental-charge-price(rental.rental-movie.movie-price-code, rental.rental-days-rented)
end;

define generic rental-charge-price
  (price :: <price-code>, days-rented :: <integer>) => (amount :: <float>);

define method rental-charge-price
    (price == #"regular", days-rented :: <integer>) => (amount :: <float>)
  let amount = 2.0;
  if (days-rented > 2)
    inc!(amount, (days-rented - 2) * 1.5)
  end;
  amount
end;

define method rental-charge-price
    (price == #"new-release", days-rented :: <integer>) => (amount :: <float>)
  days-rented * 3.0
end;

define method rental-charge-price
    (price == #"childrens", days-rented :: <integer>) => (amount :: <float>)
  let amount = 1.5;
  if (days-rented > 3)
    inc!(amount, (days-rented - 3) * 1.5)
  end;
  amount
end;

define generic rental-frequent-points
  (object :: <object>) => (points :: <integer>);

define method rental-frequent-points
    (rental :: <rental>) => (points :: <integer>)
  let price-code  = rental.rental-movie.movie-price-code;
  let days-rented = rental.rental-days-rented;
  frequent-renter-points(price-code, days-rented)
end;

define method frequent-renter-points
    (price-code :: <price-code>, days-rented :: <integer>) => (points :: <integer>)
  1
end;

define method frequent-renter-points
    (price-code == #"new-release", days-rented :: <integer>) => (points :: <integer>)
  if (days-rented > 1) 2 else 1 end
end;

define function customer-charge
    (customer :: <customer>) => (amount :: <float>)
  reduce1(\+, map(rental-charge, customer.customer-rentals))
end;

define method rental-frequent-points
    (customer :: <customer>) => (points :: <integer>)
  reduce1(\+, map(rental-frequent-points, customer.customer-rentals))
end;
