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
    <category>;
  
  create
    <movie>,
    movie-title;

  create
    <rental>,
    rental-movie, 
    rental-rented; 

  create
    <customer>,
    customer-name,
    customer-rentals,
    add-rental!;

  create
    <statement>,
    <text-statement>,
    <html-statement>,
    print-statement;
    
end module;

define module video-club-impl
  use common-dylan;
  use format;
  use format-out;
  use streams;
  
  use uncommon-utils,
    import: { inc! };
  
  use video-club;

  export
    rental-charge,
    renter-points;
end module;
