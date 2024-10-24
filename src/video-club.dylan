Module: video-club-impl

define constant $childrens = 2;
define constant $regular = 0;
define constant $new-release = 1;

define class <movie> (<object>)
  constant slot movie-title :: <string>,
    required-init-keyword: title:;
  slot movie-price-code :: <integer>,
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
  let total-amount = 0.0;
  let frequent-renter-points = 0;
  with-output-to-string (stream)
    format(stream, "Rental Record for %s\n", customer.customer-name);
    for (rental in customer.customer-rentals)
      let movie  = rental.rental-movie;

      // add frequent requent points
      inc!(frequent-renter-points, 1);
      // add bonus for a two day new release rental
      if (movie.movie-price-code = $new-release & rental.rental-days-rented > 1)
	inc!(frequent-renter-points, 1);
      end if;

      // show figures for this rental
      format(stream, "\t%30s\t%5d\n", movie.movie-title, rental.rental-amount);
      inc!(total-amount, rental.rental-amount);
    end for;

    // add footer lines
    format(stream, "Amount owed is %d\n", total-amount);
    format(stream, "You earned %d frequent renter points", frequent-renter-points);
  end with-output-to-string;
end statement;

define function rental-amount
    (rental :: <rental>)
 => (amount :: <float>)
  let amount = 0.0;
  select (rental.rental-movie.movie-price-code)
    $regular =>
      inc!(amount, 2);
      if (rental.rental-days-rented > 2)
	inc!(amount, (rental.rental-days-rented - 2) * 1.5);
      end if;
    $new-release =>
      inc!(amount, rental.rental-days-rented * 3);
    $childrens =>
      inc!(amount, 1.5);
      if (rental.rental-days-rented > 3)
	inc!(amount, (rental.rental-days-rented - 3) * 1.5);
      end if;
    otherwise =>
      error("Unknown movie price code");
  end select;
  amount
end;

