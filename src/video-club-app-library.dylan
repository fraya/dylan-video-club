Module: dylan-user
Synopsis: Module and library definition for executable application

define library video-club-app
  use common-dylan;
  use video-club;
  use io, import: { format-out };
end library;

define module video-club-app
  use common-dylan;
  use format-out;
  use video-club;
end module;
