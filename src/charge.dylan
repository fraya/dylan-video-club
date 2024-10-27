Module: video-club-impl

define constant <money>
  = <float>;

define generic charge-by-category-and-days
    (cat :: <category>, rented :: <days>) => (amount :: <money>);

define method charge-by-category-and-days
    (cat == #"regular", rented :: <days>) => (amount :: <money>)
  let amount = 2.0;
  if (rented > 2)
    inc!(amount, (rented - 2) * 1.5)
  end;
  amount
end;

define method charge-by-category-and-days
    (cat == #"new-release", rented :: <days>) => (amount :: <money>)
  rented * 3.0
end;

define method charge-by-category-and-days
    (cat == #"childrens", rented :: <days>) => (amount :: <money>)
  let amount = 1.5;
  if (rented > 3)
    inc!(amount, (rented - 3) * 1.5)
  end;
  amount
end;

define method charge-by-movie-and-days
    (movie :: <movie>, rented :: <days>) => (amount :: <money>)
  charge-by-category-and-days(movie.movie-category, rented)
end;

define generic charge
    (object :: <object>) => (amount :: <money>);

define method charge
    (rental :: <rental>) => (amount :: <money>)
  charge-by-movie-and-days(rental.rental-movie, rental.rental-rented)
end;

define method charge
    (customer :: <customer>) => (amount :: <money>)
  reduce(\+, 0.0, map-as(<vector>, charge, customer.customer-rentals))
end;
