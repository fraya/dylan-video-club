Module: dylan-user

define library video-club-test-suite
  use common-dylan;
  use testworks;
  use video-club;
end library;

define module video-club-test-suite
  use common-dylan;
  use testworks;
  use video-club;
  use video-club-impl;
end module;
