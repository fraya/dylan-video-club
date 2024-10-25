Module: video-club-impl

define function rental-charge
    (rental :: <rental>) => (amount :: <float>)
  movie-charge(rental.rental-movie, rental.rental-days-rented)
end;

define generic movie-charge
  (movie :: <movie>, days-rented :: <rented-days>) => (amount :: <float>);

define method movie-charge
    (movie :: <regular-movie>, days-rented :: <rented-days>)
 => (amount :: <float>)
  let amount = 2.0;
  if (days-rented > 2)
    inc!(amount, (days-rented - 2) * 1.5)
  end;
  amount
end;

define method movie-charge
    (movie :: <new-release-movie>, days-rented :: <rented-days>)
 => (amount :: <float>)
  days-rented * 3.0
end;

define method movie-charge
    (movie :: <childrens-movie>, days-rented :: <rented-days>)
 => (amount :: <float>)
  let amount = 1.5;
  if (days-rented > 3)
    inc!(amount, (days-rented - 3) * 1.5)
  end;
  amount
end;

define function customer-charge
    (customer :: <customer>) => (amount :: <float>)
  let amount = 0.0;
  for (rental in customer.customer-rentals)
    inc!(amount, rental.rental-charge)
  end;
  amount
end;
