Module: video-club-impl

define abstract class <movie> (<object>)
  constant slot movie-title :: <string>,
    required-init-keyword: title:;
end;

define class <childrens-movie> (<movie>) end;
define class <regular-movie> (<movie>) end;
define class <new-release-movie> (<movie>) end;

