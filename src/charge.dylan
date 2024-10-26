Module: video-club-impl

define constant <money-charge>
  = <float>;

define generic charge
  (object :: <object>, rented :: <days>) => (amount :: <money-charge>);

define method charge
    (cat == #"regular", rented :: <days>) 
 => (amount :: <float>)
  let amount = 2.0;
  if (rented > 2)
    inc!(amount, (rented - 2) * 1.5)
  end;
  amount
end;

define method charge
    (cat == #"new-release", rented :: <days>) 
 => (amount :: <float>)
  rented * 3.0
end;

define method charge
    (cat == #"childrens", rented :: <days>) 
 => (amount :: <float>)
  let amount = 1.5;
  if (rented > 3)
    inc!(amount, (rented - 3) * 1.5)
  end;
  amount
end;

define method charge
    (movie :: <movie>, rented :: <days>)
 => (amount :: <money-charge>)
  charge(movie.movie-category, rented)
end;

define function rental-charge
    (rental :: <rental>) => (amount :: <money-charge>)
  charge(rental.rental-movie, rental.rental-rented)
end;

define function customer-charge
    (customer :: <customer>) => (amount :: <money-charge>)
  reduce(\+, 0.0, map-as(<vector>, rental-charge, customer.customer-rentals))
end;
