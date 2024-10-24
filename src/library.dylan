Module: dylan-user

define library video-club
  use common-dylan;
  
  use io,
    import: { format,
	      format-out,
	      streams };
  
  use uncommon-dylan;
  
  export
    video-club,
    video-club-impl;
end library;

define module video-club

  create
    $childrens,
    $regular,
    $new-release;
  
  create
    <movie>,
    movie-title,
    movie-price-code, movie-price-code-setter;

  create
    <rental>,
    rental-movie, 
    rental-days-rented; 

  create
    <customer>,
    customer-name,
    customer-rentals,
    add-rental!,
    statement;
    
end module;

define module video-club-impl
  use common-dylan;
  use format;
  use streams;
  
  use uncommon-utils,
    import: { inc! };
  
  use video-club;

  export
    amount-for;
end module;
